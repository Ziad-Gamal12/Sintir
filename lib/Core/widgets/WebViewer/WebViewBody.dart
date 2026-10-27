import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/course_checkout_cubit/course_checkout_cubit.dart';
import 'package:sintir/Core/widgets/WebViewer/WebviewbodyPaymentSuccessWidget.dart';
import 'package:sintir/Features/Subscribtion/Domain/Entities/CourseCheckoutEntity.dart';
import 'package:sintir/Features/Subscribtion/Domain/Entities/PayMobResponse.dart';
import 'package:sintir/locale_keys.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Webviewbody extends StatefulWidget {
  const Webviewbody({
    super.key,
    required this.response,
    this.courseTitle,
    this.quote,
    this.now,
  });

  final PayMobResponse response;
  final String? courseTitle;
  final CourseCheckoutQuote? quote;
  final DateTime Function()? now;

  @override
  State<Webviewbody> createState() => _WebviewbodyState();
}

class _WebviewbodyState extends State<Webviewbody> {
  WebViewController? _controller;
  Timer? _countdownTimer;
  String _status = 'pending';
  String _verificationState = 'unknown';
  bool _checking = false;
  bool _canRetry = true;
  bool _canResume = false;
  bool _returnedFromCheckout = false;
  int _retryAfterSeconds = 0;
  DateTime? _nextCheckAt;
  String _checkoutUrl = '';
  bool _allowSuccessPop = false;
  bool _successPopQueued = false;

  @override
  void initState() {
    super.initState();
    _status = widget.response.status.toLowerCase();
    _checkoutUrl = widget.response.url;
    _returnedFromCheckout = _checkoutUrl.isEmpty;
    if (_checkoutUrl.isNotEmpty) {
      _loadCheckoutUrl();
    } else if (!['succeeded', 'failed', 'expired', 'paid_requires_review']
        .contains(_status)) {
      _startStatusCheck();
    }
  }

  WebViewController _createController() => WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setNavigationDelegate(NavigationDelegate(
      onNavigationRequest: (NavigationRequest request) {
        final url = request.url;

        final uri = Uri.tryParse(url);
        if (uri != null &&
            (uri.queryParameters.containsKey('success') ||
                uri.path.contains('payment-status'))) {
          if (mounted) {
            setState(() => _returnedFromCheckout = true);
          }
          _startStatusCheck();
        }

        return NavigationDecision.navigate;
      },
    ));

  WebViewController _getController() => _controller ??= _createController();

  void _loadCheckoutUrl() {
    _getController().loadRequest(Uri.parse(_checkoutUrl));
  }

  void _startStatusCheck() {
    if (_checking || _isTerminal || _autoCheckStarted) return;
    _autoCheckStarted = true;
    _checkStatus();
  }

  bool _autoCheckStarted = false;

  bool get _isTerminal => [
        'succeeded',
        'failed',
        'expired',
        'paid_requires_review'
      ].contains(_status);

  DateTime _currentTime() => widget.now?.call() ?? DateTime.now();

  Future<void> _checkStatus() async {
    if (_checking || !mounted || _isTerminal) {
      return;
    }
    final nextCheckAt = _nextCheckAt;
    if (nextCheckAt != null && _currentTime().isBefore(nextCheckAt)) {
      return;
    }
    _checking = true;
    if (mounted) setState(() {});
    try {
      final result = await context
          .read<CourseCheckoutCubit>()
          .refreshStatus(widget.response.paymentAttemptId);
      if (!mounted) return;
      setState(() {
        _status = result.status.toLowerCase();
        _verificationState = result.verificationState;
        _canRetry = result.canRetry;
        _canResume = result.canResume && result.checkoutUrl.isNotEmpty;
        if (_canResume) _checkoutUrl = result.checkoutUrl;
        _retryAfterSeconds = result.retryAfterSeconds;
        _nextCheckAt = result.retryAfterSeconds > 0
            ? _currentTime().add(Duration(seconds: result.retryAfterSeconds))
            : null;
      });
      if (_isTerminal) {
        _cancelChecks();
      } else if (_retryAfterSeconds > 0) {
        _startCountdown();
      } else {
        _countdownTimer?.cancel();
        _countdownTimer = null;
      }
    } finally {
      _checking = false;
      if (mounted) setState(() {});
    }
  }

  Future<void> _manualRefresh() async {
    if (_checking || _isTerminal || _retryAfterSeconds > 0 || !_canRefresh) {
      return;
    }
    await _checkStatus();
  }

  void _resumePayment() {
    if (!_canResume || _checkoutUrl.isEmpty || _checking || !mounted) return;
    final controller = _getController();
    _cancelChecks();
    setState(() {
      _returnedFromCheckout = false;
      _retryAfterSeconds = 0;
      _nextCheckAt = null;
      _autoCheckStarted = false;
    });
    controller.loadRequest(Uri.parse(_checkoutUrl));
  }

  void _startCountdown() {
    _countdownTimer?.cancel();
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted || _nextCheckAt == null) {
        timer.cancel();
        return;
      }
      final remainingMs =
          _nextCheckAt!.difference(_currentTime()).inMilliseconds;
      final remaining = remainingMs <= 0 ? 0 : (remainingMs + 999) ~/ 1000;
      setState(() => _retryAfterSeconds = remaining);
      if (_retryAfterSeconds == 0) timer.cancel();
    });
  }

  void _cancelChecks() {
    _countdownTimer?.cancel();
    _countdownTimer = null;
  }

  void _returnFromSuccess() {
    if (!mounted || !_isSuccess || _successPopQueued) return;
    _successPopQueued = true;
    setState(() => _allowSuccessPop = true);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) Navigator.of(context).pop(true);
    });
  }

  @override
  void dispose() {
    _cancelChecks();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope<Object?>(
      canPop: !_isSuccess || _allowSuccessPop,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop && _isSuccess) _returnFromSuccess();
      },
      child: _buildContent(context),
    );
  }

  bool get _isSuccess => _status == 'succeeded';

  Widget _buildContent(BuildContext context) {
    if (_isSuccess) {
      return WebviewbodyPaymentSuccessWidget(
        courseTitle: widget.courseTitle,
        quote: widget.quote,
        onContinue: _returnFromSuccess,
      );
    }
    if (_returnedFromCheckout) {
      final message = switch (_status) {
        'failed' => LocaleKeys.paymentNotCompleted,
        'expired' => LocaleKeys.checkoutExpired,
        'unavailable' => LocaleKeys.paymentStatusUnavailable,
        'paid_requires_review' => LocaleKeys.paymentRequiresReview,
        _
            when _verificationState == 'provider_unavailable' ||
                _verificationState == 'request_failed' =>
          LocaleKeys.paymentStatusUnavailable,
        _ when _verificationState == 'fulfillment_retry_required' =>
          LocaleKeys.paymentFinalizingEnrollment,
        'verification_required' => LocaleKeys.paymentVerifying,
        _ => LocaleKeys.paymentVerifying,
      };
      final checkLabel = _retryAfterSeconds > 0
          ? LocaleKeys.paymentCheckCooldown(_retryAfterSeconds)
          : LocaleKeys.checkPaymentStatus;
      return Center(
          child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                if (_checking)
                  Semantics(
                    liveRegion: true,
                    label: LocaleKeys.paymentCheckingStatus,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox.square(
                            dimension: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Flexible(
                            child: Text(LocaleKeys.paymentCheckingStatus),
                          ),
                        ],
                      ),
                    ),
                  ),
                const SizedBox(height: 16),
                Semantics(
                  liveRegion: !_checking,
                  child: Text(message, textAlign: TextAlign.center),
                ),
                TextButton(
                    key: const Key('verification_check_status'),
                    onPressed:
                        _checking || _retryAfterSeconds > 0 || !_canRefresh
                            ? null
                            : _manualRefresh,
                    child: Text(checkLabel)),
                if (_canResume)
                  FilledButton(
                    onPressed: _checking ? null : _resumePayment,
                    child: Text(LocaleKeys.resumeCheckout),
                  ),
                TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: Text(LocaleKeys.leaveCheckout)),
              ])));
    }
    return WebViewWidget(controller: _controller!);
  }

  bool get _canRefresh =>
      _canRetry &&
      !_isTerminal &&
      _verificationState != 'fulfillment_inconsistent';
}

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/course_checkout_cubit/course_checkout_cubit.dart';
import 'package:sintir/Core/widgets/WebViewer/WebviewbodyPaymentSuccessWidget.dart';
import 'package:sintir/Features/Subscribtion/Domain/Entities/PayMobResponse.dart';
import 'package:sintir/constant.dart';
import 'package:sintir/locale_keys.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Webviewbody extends StatefulWidget {
  const Webviewbody({super.key, required this.response});
  final PayMobResponse response;
  @override
  State<Webviewbody> createState() => _WebviewbodyState();
}

class _WebviewbodyState extends State<Webviewbody> {
  late WebViewController controller;
  Timer? _pollTimer;
  Timer? _countdownTimer;
  String _status = 'pending';
  String _verificationState = 'unknown';
  bool _checking = false;
  bool _returnedFromCheckout = false;
  int _checks = 0;
  int _retryAfterSeconds = 0;
  DateTime? _nextCheckAt;

  @override
  void initState() {
    super.initState();
    _status = widget.response.status.toLowerCase();
    _returnedFromCheckout = widget.response.url.isEmpty;
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (NavigationRequest request) {
            final url = request.url;

            final uri = Uri.tryParse(url);
            if (uri != null &&
                (uri.queryParameters.containsKey('success') ||
                    uri.path.contains('payment-status'))) {
              if (mounted && !_returnedFromCheckout) {
                setState(() => _returnedFromCheckout = true);
              }
              _startPolling();
            }

            return NavigationDecision.navigate;
          },
        ),
      );
    if (widget.response.url.isNotEmpty) {
      controller.loadRequest(Uri.parse(widget.response.url));
    } else if (!['succeeded', 'failed', 'expired', 'paid_requires_review']
        .contains(_status)) {
      _startPolling();
    }
  }

  void _startPolling() {
    if (_checking || _pollTimer != null || _isTerminal) return;
    _scheduleCheck(Duration.zero);
  }

  bool get _isTerminal =>
      ['succeeded', 'failed', 'expired', 'paid_requires_review']
          .contains(_status);

  void _scheduleCheck(Duration delay) {
    _pollTimer?.cancel();
    if (delay == Duration.zero) {
      _pollTimer = null;
      _checkStatus();
    } else {
      _pollTimer = Timer(delay, () {
        _pollTimer = null;
        _checkStatus();
      });
    }
  }

  Future<void> _checkStatus() async {
    if (_checking || !mounted || _isTerminal) {
      return;
    }
    if (_checks >= 30) return;
    final nextCheckAt = _nextCheckAt;
    if (nextCheckAt != null && DateTime.now().isBefore(nextCheckAt)) {
      _scheduleCheck(nextCheckAt.difference(DateTime.now()));
      return;
    }
    _checking = true;
    _checks++;
    if (mounted) setState(() {});
    try {
      final result = await context
          .read<CourseCheckoutCubit>()
          .refreshStatus(widget.response.paymentAttemptId);
      if (!mounted) return;
      setState(() {
        _status = result.status.toLowerCase();
        _verificationState = result.verificationState;
        _retryAfterSeconds = result.retryAfterSeconds;
        _nextCheckAt = result.retryAfterSeconds > 0
            ? DateTime.now().add(Duration(seconds: result.retryAfterSeconds))
            : null;
      });
      if (_isTerminal) {
        _cancelChecks();
      } else if (_retryAfterSeconds > 0) {
        _startCountdown();
        _scheduleCheck(Duration(seconds: _retryAfterSeconds));
      } else {
        _scheduleCheck(const Duration(seconds: 4));
      }
    } finally {
      _checking = false;
      if (mounted) setState(() {});
    }
  }

  Future<void> _manualRefresh() async {
    if (_checking || _isTerminal || _retryAfterSeconds > 0) return;
    _checks = 0;
    _pollTimer?.cancel();
    _pollTimer = null;
    await _checkStatus();
  }

  void _startCountdown() {
    _countdownTimer?.cancel();
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted || _nextCheckAt == null) {
        timer.cancel();
        return;
      }
      final remaining = _nextCheckAt!.difference(DateTime.now()).inSeconds;
      setState(() => _retryAfterSeconds = remaining < 0 ? 0 : remaining);
      if (_retryAfterSeconds == 0) timer.cancel();
    });
  }

  void _cancelChecks() {
    _pollTimer?.cancel();
    _countdownTimer?.cancel();
    _pollTimer = null;
    _countdownTimer = null;
  }

  @override
  void dispose() {
    _cancelChecks();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    if (_status == 'succeeded') {
      return WebviewbodyPaymentSuccessWidget(
        onContinue: () => Navigator.of(context).pop(true),
      );
    }
    if (_returnedFromCheckout) {
      final message = switch (_status) {
        'failed' => LocaleKeys.paymentNotCompleted,
        'expired' => LocaleKeys.checkoutExpired,
        'unavailable' => LocaleKeys.paymentStatusUnavailable,
        'paid_requires_review' => LocaleKeys.paymentRequiresReview,
        _ when _verificationState == 'provider_unavailable' ||
            _verificationState == 'request_failed' =>
          LocaleKeys.paymentStatusUnavailable,
        _ when _verificationState == 'fulfillment_retry_required' =>
          isArabic
              ? 'تم تأكيد الدفع. جارٍ إتمام إتاحة الدورة. تحقق مرة أخرى بعد قليل.'
              : 'Payment is confirmed. Course access is still being finalized. Check again shortly.',
        'verification_required' => LocaleKeys.paymentVerifying,
        _ => LocaleKeys.paymentVerifying,
      };
      final checkLabel = _retryAfterSeconds > 0
          ? (isArabic
                  ? 'يمكنك التحقق من حالة الدفع مرة أخرى بعد $_retryAfterSeconds ثانية.'
                  : 'You can check payment status again in $_retryAfterSeconds seconds.')
          : LocaleKeys.checkPaymentStatus;
      return Center(
          child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                if (_checking)
                  const CircularProgressIndicator(color: KMainColor),
                const SizedBox(height: 16),
                Text(message, textAlign: TextAlign.center),
                TextButton(
                    onPressed: _checking ||
                            _retryAfterSeconds > 0 ||
                            !_canRefresh
                        ? null
                        : _manualRefresh,
                    child: _checking
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : Text(checkLabel)),
                TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: Text(LocaleKeys.leaveCheckout)),
              ])));
    }
    return WebViewWidget(controller: controller);
  }

  bool get _canRefresh =>
      !_isTerminal && _verificationState != 'fulfillment_inconsistent';
}

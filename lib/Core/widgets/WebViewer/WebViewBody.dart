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
  String _status = 'pending';
  bool _checking = false;
  bool _returnedFromCheckout = false;
  int _checks = 0;

  @override
  void initState() {
    super.initState();
    _status = widget.response.status.toLowerCase();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (NavigationRequest request) {
            final url = request.url;

            final uri = Uri.tryParse(url);
            if (uri != null && (uri.queryParameters.containsKey('success') || uri.path.contains('payment-status'))) {
              _returnedFromCheckout = true;
              _startPolling();
            }

            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.response.url));

  }

  void _startPolling() {
    if (_pollTimer != null) return;
    _pollTimer = Timer.periodic(const Duration(seconds: 4), (_) => _checkStatus());
    _checkStatus();
  }

  Future<void> _checkStatus() async {
    if (_checking || !mounted || _checks >= 30 || ['succeeded', 'failed', 'expired', 'paid_requires_review'].contains(_status)) return;
    _checking = true;
    _checks++;
    try {
      final result = await context.read<CourseCheckoutCubit>().refreshStatus(widget.response.paymentAttemptId);
      if (!mounted) return;
      setState(() => _status = result.toLowerCase());
      if (['succeeded', 'failed', 'expired', 'paid_requires_review'].contains(_status)) _pollTimer?.cancel();
    } finally {
      _checking = false;
    }
  }

  Future<void> _manualRefresh() async {
    _checks = 0;
    _pollTimer?.cancel();
    _pollTimer = null;
    await _checkStatus();
    if (mounted && !['succeeded', 'failed', 'expired', 'paid_requires_review'].contains(_status)) {
      _pollTimer = Timer.periodic(const Duration(seconds: 4), (_) => _checkStatus());
    }
  }

  @override
  void dispose() {
    _pollTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_status == 'succeeded') return const WebviewbodyPaymentSuccessWidget();
    if (_returnedFromCheckout) {
      final message = switch (_status) {
        'failed' => LocaleKeys.paymentNotCompleted,
        'expired' => LocaleKeys.checkoutExpired,
        'unavailable' => LocaleKeys.paymentStatusUnavailable,
        'paid_requires_review' => LocaleKeys.paymentRequiresReview,
        _ => LocaleKeys.paymentVerifying,
      };
      return Center(child: Padding(padding: const EdgeInsets.all(24), child: Column(mainAxisSize: MainAxisSize.min, children: [
        if (!['failed', 'expired', 'paid_requires_review'].contains(_status)) const CircularProgressIndicator(color: KMainColor),
        const SizedBox(height: 16), Text(message, textAlign: TextAlign.center),
        TextButton(onPressed: _manualRefresh, child: Text(LocaleKeys.checkPaymentStatus)),
        TextButton(onPressed: () => Navigator.of(context).maybePop(), child: Text(LocaleKeys.leaveCheckout)),
      ])));
    }
    return WebViewWidget(controller: controller);
  }
}

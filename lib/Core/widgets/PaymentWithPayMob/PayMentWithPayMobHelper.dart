import 'package:flutter/material.dart';
import 'package:sintir/Features/Subscribtion/Domain/Entities/PayMobResponse.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PayMentWithPayMobHelper {
  final PayMobResponse response;
  PayMentWithPayMobHelper({required this.response});
  late WebViewController controller;

  void initPayment({required BuildContext context}) {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (NavigationRequest request) {
            final url = request.url;
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(response.url));
  }
}

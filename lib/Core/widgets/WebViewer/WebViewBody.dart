import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/widgets/AwesomeDialog.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Webviewbody extends StatefulWidget {
  const Webviewbody({super.key, required this.url});
  final String url;

  @override
  State<Webviewbody> createState() => _WebviewbodyState();
}

class _WebviewbodyState extends State<Webviewbody> {
  late WebViewController controller;
  bool isPageFinished = false;
  @override
  void initState() {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onUrlChange: (url) {
            log("url $url");
          },
          onProgress: (int progress) {
            log("WebView is loading (progress : $progress%)");
          },
          onPageStarted: (String url) {
            log("Page started: $url");
            setState(() {
              isPageFinished = false;
            });
          },
          onPageFinished: (String url) {
            log("Page finished: $url");
            if (url.contains('payment-success')) {
              log("Payment Successful!");
              if (!isPageFinished) {
                setState(() {
                  isPageFinished = true;
                });
                GoRouter.of(context).pop();
                successdialog(
                        context: context,
                        SuccessMessage: "تم الدفع بنجاح",
                        btnOkOnPress: () {})
                    .show();
              }
            } else if (url.contains('payment-failed')) {
              log("Payment Failed");
              if (!isPageFinished) {
                GoRouter.of(context).pop();

                errordialog(context, "لم يتم الدفع بنجاح").show();
                setState(() {
                  isPageFinished = true;
                });
              }
            }
          },
          onHttpError: (HttpResponseError error) {
            log("error ${error.response!.statusCode}");
          },
          onWebResourceError: (WebResourceError error) {
            log("error ${error.errorCode}");
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith("https://accept.paymob.com/")) {
              return NavigationDecision.navigate;
            }
            return NavigationDecision.prevent;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WebViewWidget(controller: controller);
  }
}

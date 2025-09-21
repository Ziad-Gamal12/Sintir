import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sintir/Core/Managers/Cubits/CourseSubscribtionsCubit/CourseSubscribtionsCubit.dart';
import 'package:sintir/Core/entities/PayMobResponse.dart';
import 'package:sintir/Core/helper/GetUserData.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Webviewbody extends StatefulWidget {
  const Webviewbody({super.key, required this.response});
  final PayMobResponse response;

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
          onPageStarted: (String url) {
            setState(() {
              isPageFinished = false;
            });
          },
          onPageFinished: (String url) {
            log("Page finished: $url");
            Uri uri = Uri.parse(url);
            if (uri.path.contains('success=true')) {
              if (!isPageFinished) {
                setState(() {
                  isPageFinished = true;
                });
                GoRouter.of(context).pop();
                context.read<CourseSubscribtionsCubit>().subscribeToCourse(
                    userEntity: getUserData(),
                    transactionId: widget.response.paymentid);
              }
            } else if (url.contains('success=false')) {
              if (!isPageFinished) {
                setState(() {
                  isPageFinished = true;
                });
              }
            }
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith("https://accept.paymob.com/")) {
              return NavigationDecision.navigate;
            }
            return NavigationDecision.prevent;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.response.url));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WebViewWidget(controller: controller);
  }
}

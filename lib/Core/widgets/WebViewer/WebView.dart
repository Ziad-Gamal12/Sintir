import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/PayMobResponse.dart';
import 'package:sintir/Core/widgets/CustomAppBar.dart';
import 'package:sintir/Core/widgets/WebViewer/WebViewBody.dart';

class Webviewer extends StatelessWidget {
  const Webviewer({super.key, required this.response});
  static const routeName = '/WebView';
  final PayMobResponse response;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(appBartitle: "الموقع الالكتروني"),
      body: Webviewbody(response: response),
    );
  }
}

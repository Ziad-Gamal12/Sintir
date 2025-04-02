import 'package:flutter/material.dart';
import 'package:sintir/Core/widgets/CustomAppBar.dart';
import 'package:sintir/Core/widgets/WebViewer/WebViewBody.dart';

class Webviewer extends StatelessWidget {
  const Webviewer({super.key, required this.url});
  static const routeName = '/WebView';
  final String url;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(appBartitle: "الموقع الالكتروني"),
      body: Webviewbody(url: url),
    );
  }
}

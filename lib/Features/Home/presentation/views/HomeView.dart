// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sintir/Features/Home/presentation/views/widgets/Homeview_Body.dart';

class Homeview extends StatelessWidget {
  const Homeview({super.key});
  static const String routeName = '/HomeView';
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(child: Homeview_Body()),
    );
  }
}

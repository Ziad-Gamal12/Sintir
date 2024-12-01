// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/Variables.dart';
import 'package:sintir/Core/widgets/CustomDrawerWidgets/CustomDrawer.dart';
import 'package:sintir/Features/Home/presentation/views/widgets/Homeview_Body.dart';

class Homeview extends StatelessWidget {
  const Homeview({super.key});
  static const String routeName = '/HomeView';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Variables.HomeViewScaffoldKey,
      endDrawer: const Customdrawer(),
      body: SafeArea(child: Homeview_Body()),
    );
  }
}

// ignore_for_file: camel_case_types, file_names

import 'package:flutter/material.dart';
import 'package:sintir/Core/widgets/CustomSearchTextField.dart';
import 'package:sintir/Features/Home/presentation/views/widgets/HomeViewBodyAppBar.dart';
import 'package:sintir/constant.dart';

class Homeview_Body extends StatelessWidget {
  const Homeview_Body({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            children: [
              SizedBox(
                height: 40,
              ),
              HomeViewBodyAppBar(),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: KHorizontalPadding),
                child: CustomSearchTextField(),
              )
            ],
          ),
        ),
      ],
    );
  }
}

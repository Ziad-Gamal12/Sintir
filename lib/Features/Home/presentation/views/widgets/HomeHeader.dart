import 'package:flutter/material.dart';
import 'package:sintir/Core/widgets/CustomTextFields/CustomSearchTextField.dart';
import 'package:sintir/Features/Home/presentation/views/widgets/HomeViewBodyAppBar.dart';

class HomeHeader extends StatelessWidget {
  final TextEditingController controller;

  const HomeHeader({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const HomeViewBodyAppBar(),
        const SizedBox(height: 10),
        CustomSearchTextField(
          controller: controller,
        ),
      ],
    );
  }
}

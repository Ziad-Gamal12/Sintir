// ignore_for_file: file_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:sintir/Features/ChoosingUserKind/Presentation/views/widgets/ChoosingUserKindButton.dart';
import 'package:sintir/Features/ChoosingUserKind/Presentation/views/widgets/CustomChoosingUserKindSmoothPageIndicator.dart';
import 'package:sintir/Features/ChoosingUserKind/Presentation/views/widgets/CustomPageView.dart';
import 'package:sintir/constant.dart';

class ChoosingUserKindBody extends StatefulWidget {
  const ChoosingUserKindBody({super.key});

  @override
  State<ChoosingUserKindBody> createState() => _ChoosingUserKindBodyState();
}

class _ChoosingUserKindBodyState extends State<ChoosingUserKindBody> {
  PageController pageController = PageController();
  int currentPage = 0;
  @override
  void initState() {
    pageController.addListener(() {
      currentPage = pageController.page!.round();
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: 30, horizontal: KHorizontalPadding),
      child: Column(
        children: [
          Expanded(
              flex: 8,
              child: Custompageview(
                controller: pageController,
              )),
          const Spacer(),
          CustomChoosingUserKindSmoothPageIndicator(
              pageController: pageController),
          const SizedBox(
            height: 30,
          ),
          ChoosingUserKindButton(currentPage: currentPage)
        ],
      ),
    );
  }
}

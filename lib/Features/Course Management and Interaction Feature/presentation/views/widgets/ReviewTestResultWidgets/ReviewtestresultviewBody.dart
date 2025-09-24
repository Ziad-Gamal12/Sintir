// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sintir/Core/widgets/CustomListORGridTextHeader.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/ReviewTestResultWidgets/CustomSolvedQuestionSliverList.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/ReviewTestResultWidgets/ResultDetails.dart';
import 'package:sintir/constant.dart';

class Reviewtestresultviewbody extends StatelessWidget {
  const Reviewtestresultviewbody({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: KHorizontalPadding),
      child: CustomScrollView(slivers: [
        const SliverToBoxAdapter(
          child: ResultDetails(),
        ),
        const SliverToBoxAdapter(
          child: Divider(
            height: 40,
            color: Color(0xffE5E5EA),
          ),
        ),
        SliverToBoxAdapter(
          child: CustomListORGridTextHeader(
            text: "أسئلةالأمتحان :",
          ),
        ),
        const SliverToBoxAdapter(
            child: SizedBox(
          height: 10,
        )),
        const Customsolvedquestionsliverlist(),
      ]),
    );
  }
}

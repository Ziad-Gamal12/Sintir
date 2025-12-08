// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/TestResulteEntity.dart';
import 'package:sintir/Core/widgets/CustomErrorWidget.dart';
import 'package:sintir/Core/widgets/CustomListORGridTextHeader.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/manager/CheckIfResultHidden/check_if_result_hidden_cubit.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/ReviewTestResultWidgets/CustomHiddenResultWidget.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/ReviewTestResultWidgets/CustomSolvedQuestionSliverList.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/ReviewTestResultWidgets/ResultDetails.dart';
import 'package:sintir/constant.dart';
import 'package:sintir/locale_keys.dart';

class Reviewtestresultviewbody extends StatefulWidget {
  const Reviewtestresultviewbody({super.key});

  @override
  State<Reviewtestresultviewbody> createState() =>
      _ReviewtestresultviewbodyState();
}

class _ReviewtestresultviewbodyState extends State<Reviewtestresultviewbody> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      TestResultEntity testResult = context.read<TestResultEntity>();
      context.read<CheckIfResultHiddenCubit>().checkIfResultHidden(
          testId: testResult.testId,
          sectionId: testResult.sectionId,
          courseId: testResult.courseId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckIfResultHiddenCubit, CheckIfResultHiddenState>(
      builder: (context, state) {
        if (state is CheckIfResultHiddenLoadingState) {
          return const Center(
            child: CircularProgressIndicator(
              color: KMainColor,
            ),
          );
        } else if (state is CheckIfResultHiddenFailureState) {
          return Center(
            child: CustomErrorWidget(errormessage: state.message),
          );
        } else if (state is CheckIfResultHiddenSuccessState && state.isHidden) {
          return const Center(child: CustomHiddenResultWidget());
        }
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
                text: "${LocaleKeys.totalQuestions} :",
              ),
            ),
            const SliverToBoxAdapter(
                child: SizedBox(
              height: 10,
            )),
            const Customsolvedquestionsliverlist(),
          ]),
        );
      },
    );
  }
}

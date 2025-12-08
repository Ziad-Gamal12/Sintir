import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/TestResulteEntity.dart';
import 'package:sintir/Core/widgets/CustomEmptyWidget.dart';
import 'package:sintir/Core/widgets/CustomErrorWidget.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/manager/TestOverViewCubit/TestOverViewCubit.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TestConsequencesViewWidgets/StudentResultCard.dart';
import 'package:sintir/constant.dart';
import 'package:sintir/locale_keys.dart';

class CourseTestOverViewBodyListView extends StatefulWidget {
  const CourseTestOverViewBodyListView({super.key});

  @override
  State<CourseTestOverViewBodyListView> createState() =>
      _CourseTestOverViewBodyListViewState();
}

class _CourseTestOverViewBodyListViewState
    extends State<CourseTestOverViewBodyListView> {
  List<TestResultEntity> results = [];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TestOverViewCubit, TestOverViewState>(
        buildWhen: (previous, current) {
      return current is GetUserPerviousResultsOfExamSuccess ||
          current is GetUserPerviousResultsOfExamFailure ||
          current is GetUserPerviousResultsOfExamLoading;
    }, listener: (context, state) {
      if (state is GetUserPerviousResultsOfExamSuccess) {
        results = state.resultsOfExamsList;
      }
    }, builder: (context, state) {
      if (state is GetUserPerviousResultsOfExamLoading) {
        return const SliverToBoxAdapter(
          child: Center(
            child: CircularProgressIndicator(
              color: KMainColor,
            ),
          ),
        );
      } else if (state is GetUserPerviousResultsOfExamFailure) {
        return SliverToBoxAdapter(
          child: Center(
            child: CustomErrorWidget(
              errormessage: state.errMessage,
            ),
          ),
        );
      } else if (state is GetUserPerviousResultsOfExamSuccess &&
          results.isEmpty) {
        return SliverToBoxAdapter(
            child: CustomEmptyWidget(text: LocaleKeys.noResults));
      } else {
        return SliverList.builder(
          itemCount: results.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: AspectRatio(
                  aspectRatio: 2 / 1.75,
                  child: StudentResultCard(
                    testResultEntity: results[index],
                  )),
            );
          },
        );
      }
    });
  }
}

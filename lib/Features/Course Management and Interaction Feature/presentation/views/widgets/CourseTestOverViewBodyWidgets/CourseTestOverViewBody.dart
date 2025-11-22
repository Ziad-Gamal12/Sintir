import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestViewNavigationsRequirmentsEntity.dart';
import 'package:sintir/Core/helper/GetUserData.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/manager/GetUserPerviousResultsOfExam/get_user_pervious_results_of_exam_cubit.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CourseTestOverViewBodyWidgets/CourseTestOverViewBodyListView.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CourseTestOverViewBodyWidgets/CourseTestOverViewBodyListViewHeader.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CourseTestOverViewBodyWidgets/OverviewHeaderCard.dart';
import 'package:sintir/constant.dart';

class CourseTestOverViewBody extends StatefulWidget {
  const CourseTestOverViewBody({
    super.key,
    required this.navigationRequirements,
  });

  final CourseExamViewNavigationsRequirmentsEntity navigationRequirements;

  @override
  State<CourseTestOverViewBody> createState() => _CourseTestOverViewBodyState();
}

class _CourseTestOverViewBodyState extends State<CourseTestOverViewBody> {
  @override
  void initState() {
    super.initState();
    final cubit = context.read<GetUserPerviousResultsOfExamCubit>();
    final entity = widget.navigationRequirements;

    cubit.getUserPerviousResultsOfExam(
      courseId: entity.course.id,
      sectionId: entity.sectionId,
      examId: entity.test.id,
      userId: getUserData().uid,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: KHorizontalPadding,
        vertical: KVerticalPadding,
      ),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                OverviewHeaderCard(
                  entity: widget.navigationRequirements,
                ),
                const SizedBox(height: 32),
                const CourseTestOverViewBodyListViewHeader(),
                const SizedBox(height: 12),
              ],
            ),
          ),
          const CourseTestOverViewBodyListView(),
        ],
      ),
    );
  }
}

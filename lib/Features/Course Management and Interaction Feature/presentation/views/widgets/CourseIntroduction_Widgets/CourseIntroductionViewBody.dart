import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/CourseSectionsCubit/CourseSectionsCubit.dart';
import 'package:sintir/Core/entities/BottomSheetNavigationRequirmentsEntity.dart';
import 'package:sintir/Core/widgets/ScreenErrorwidget.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CourseIntroduction_Widgets/CourseIntroductionLoadingView.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CourseIntroduction_Widgets/CourseIntroductionSuccessView.dart';

class CourseIntroductionViewBody extends StatefulWidget {
  const CourseIntroductionViewBody({super.key});

  @override
  State<CourseIntroductionViewBody> createState() =>
      _CourseIntroductionViewBodyState();
}

class _CourseIntroductionViewBodyState
    extends State<CourseIntroductionViewBody> {
  @override
  void initState() {
    super.initState();
    if (mounted) {
      context.read<CourseSectionsCubit>().getCourseSections(
          courseId: context
              .read<DisplayCourseBottomsheetNavigationRequirmentsEntity>()
              .course
              .id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CourseSectionsCubit, CourseSectionsState>(
      buildWhen: (previous, current) {
        return current is GetCourseSectionsSuccess ||
            current is GetCourseSectionsFailure ||
            current is GetCourseSectionsLoading;
      },
      builder: (context, state) {
        if (state is GetCourseSectionsSuccess) {
          return CourseIntroductionSuccessView(sections: state.sections);
        } else if (state is GetCourseSectionsFailure) {
          return Center(
            child: ScreenErrorwidget(
              errMessage: state.errMessage,
            ),
          );
        } else if (state is GetCourseSectionsLoading) {
          return const CourseIntroductionLoadingView();
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

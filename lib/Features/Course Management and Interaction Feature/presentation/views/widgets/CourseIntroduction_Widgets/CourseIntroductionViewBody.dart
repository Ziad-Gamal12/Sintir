import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/CourseSectionsCubit/CourseSectionsCubit.dart';
import 'package:sintir/Core/entities/BottomSheetNavigationRequirmentsEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseSectionEntity.dart';
import 'package:sintir/Core/widgets/CustomErrorWidget.dart';
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
  late ScrollController scrollController;
  bool hasMore = true;
  List<CourseSectionEntity> fetchedSections = [];

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    final cubit = context.read<CourseSectionsCubit>();
    final courseId = context
        .read<DisplayCourseBottomsheetNavigationRequirmentsEntity>()
        .course
        .id;

    cubit.getCourseSections(isPaginate: false, courseId: courseId);
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent - 200 &&
          hasMore &&
          cubit.state is! GetCourseSectionsLoading) {
        cubit.getCourseSections(isPaginate: true, courseId: courseId);
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CourseSectionsCubit, CourseSectionsState>(
      listenWhen: (previous, current) =>
          current is GetCourseSectionsSuccess ||
          current is GetCourseSectionsFailure,
      listener: (context, state) {
        if (state is GetCourseSectionsSuccess) {
          setState(() {
            if (state.response.isPaginate) {
              fetchedSections.addAll(state.response.sections);
            } else {
              fetchedSections = state.response.sections;
            }
            hasMore = state.response.hasMore;
          });
        }
      },
      buildWhen: (previous, current) =>
          current is GetCourseSectionsSuccess ||
          current is GetCourseSectionsFailure ||
          current is GetCourseSectionsLoading,
      builder: (context, state) {
        if (state is GetCourseSectionsSuccess) {
          return CourseIntroductionSuccessView(
            sections: fetchedSections,
            scrollController: scrollController,
          );
        } else if (state is GetCourseSectionsFailure) {
          return Center(
            child: CustomErrorWidget(errormessage: state.errMessage),
          );
        } else if (state is GetCourseSectionsLoading &&
            fetchedSections.isEmpty) {
          return const CourseIntroductionLoadingView();
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

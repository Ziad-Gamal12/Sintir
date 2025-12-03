// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/helper/ShowSnackBar.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseActionButton.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseInfoSectionWidgets/CustomCourseDetailsBodyCourse_Info.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsRowOptionsSectionWidgets/CourseDetailsViewRowOptions.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/UpdateCourseCubit/Update_Course_Cubit.dart';
import 'package:sintir/constant.dart';
import 'package:sintir/locale_keys.dart';

class CourseDetailViewBody extends StatefulWidget {
  CourseDetailViewBody({super.key, required this.courseEntity});
  CourseEntity courseEntity;

  @override
  State<CourseDetailViewBody> createState() => _CourseDetailViewBodyState();
}

class _CourseDetailViewBodyState extends State<CourseDetailViewBody> {
  late ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    _initControllers();
  }

  void _initControllers() {
    scrollController = ScrollController();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdateCourseCubit, UpdateCourseState>(
      listener: (context, state) {
        if (state is UpdateCourseStateSuccess) {
          CustomSnackBar.show(
            context,
            message: LocaleKeys.operationSuccessful,
            type: SnackType.success,
          );
          widget.courseEntity.state = state.courseEntity.state;
          setState(() {});
        } else if (state is UpdateCourseStateFailure) {
          CustomSnackBar.show(
            context,
            message: state.errmessage,
            type: SnackType.error,
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: KHorizontalPadding, vertical: KVerticalPadding),
        child: CustomScrollView(
          controller: scrollController,
          slivers: [
            SliverToBoxAdapter(
              child: CustomCourseDetailsBodyCourseInfo(
                courseEntity: widget.courseEntity,
              ),
            ),
            SliverToBoxAdapter(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                Text(
                  LocaleKeys.courseDetails,
                  style: AppTextStyles(context).bold20.copyWith(
                      color: Theme.of(context).textTheme.bodyLarge?.color),
                ),
                const SizedBox(height: 20),
              ],
            )),
            CourseDetailsViewRowOptions(
              course: widget.courseEntity,
            ),
            SliverToBoxAdapter(
              child: CourseActionButton(courseEntity: widget.courseEntity),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/helper/ShowSnackBar.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/CoursedetailsviewOptionitemEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/course_detail_actions.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/course_detail_management_tile.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/course_detail_metadata.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/course_detail_poster.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/course_detail_summary.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/UpdateCourseCubit/Update_Course_Cubit.dart';
import 'package:sintir/locale_keys.dart';

class CourseDetailScreenBody extends StatefulWidget {
  const CourseDetailScreenBody({super.key, required this.course});

  final CourseEntity course;

  @override
  State<CourseDetailScreenBody> createState() => _CourseDetailScreenBodyState();
}

class _CourseDetailScreenBodyState extends State<CourseDetailScreenBody> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdateCourseCubit, UpdateCourseState>(
      listener: _handleCourseUpdate,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final contentWidth =
              constraints.maxWidth.clamp(0.0, 760.0).toDouble();
          final managementItems = CoursedetailsviewOptionitemEntity.toList(
            context: context,
            course: widget.course,
          );

          return SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
            child: Center(
              child: SizedBox(
                width: contentWidth,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CourseDetailPoster(course: widget.course),
                    const SizedBox(height: 16),
                    CourseDetailSummary(course: widget.course),
                    const SizedBox(height: 12),
                    CourseDetailMetadata(course: widget.course),
                    const SizedBox(height: 22),
                    _ManagementSectionHeader(),
                    const SizedBox(height: 10),
                    ...managementItems.map(
                      (item) => Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: CourseDetailManagementTile(item: item),
                      ),
                    ),
                    const SizedBox(height: 10),
                    CourseDetailActions(course: widget.course),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _handleCourseUpdate(BuildContext context, UpdateCourseState state) {
    if (state is UpdateCourseStateSuccess) {
      widget.course.state = state.courseEntity.state;
      CustomSnackBar.show(
        context,
        message: LocaleKeys.operationSuccessful,
        type: SnackType.success,
      );
      setState(() {});
    } else if (state is UpdateCourseStateFailure) {
      CustomSnackBar.show(
        context,
        message: state.errmessage,
        type: SnackType.error,
      );
    }
  }
}

class _ManagementSectionHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textStyles = AppTextStyles(context);

    return Row(
      children: [
        Expanded(
          child: Text(
            LocaleKeys.courseManagement,
            style: textStyles.bold20.copyWith(
              color: theme.textTheme.bodyLarge?.color,
            ),
          ),
        ),
        Text(
          LocaleKeys.courseManagementCount,
          style: textStyles.regular12.copyWith(
            color: theme.textTheme.bodySmall?.color,
          ),
        ),
      ],
    );
  }
}

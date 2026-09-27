import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/utils/Backend_EndPoints.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseInfoSectionWidgets/CustomCourseDetails_EditeCoureInfoWidget.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/course_archive_confirmation_sheet.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/UpdateCourseCubit/Update_Course_Cubit.dart';
import 'package:sintir/locale_keys.dart';

class CourseDetailActions extends StatelessWidget {
  const CourseDetailActions({super.key, required this.course});

  final CourseEntity course;

  @override
  Widget build(BuildContext context) {
    final isArchived = course.state == BackendEndpoints.courseDeletedState;

    return _ActionsLayout(
      isArchived: isArchived,
      onEdit: () => _openEditSheet(context),
      onArchiveOrRestore: () =>
          isArchived ? _restoreCourse(context) : _confirmArchive(context),
    );
  }

  void _openEditSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => BlocProvider.value(
        value: context.read<UpdateCourseCubit>(),
        child: SingleChildScrollView(
          child: EditCourseInfoSection(course: course),
        ),
      ),
    );
  }

  Future<void> _confirmArchive(BuildContext context) async {
    final confirmed = await CourseArchiveConfirmationSheet.show(context);
    if (!confirmed || !context.mounted) return;
    _updateCourseState(context, BackendEndpoints.courseDeletedState);
  }

  void _restoreCourse(BuildContext context) {
    _updateCourseState(context, BackendEndpoints.coursePublishedState);
  }

  void _updateCourseState(BuildContext context, String nextState) {
    // Apply changes to the displayed course only after the repository succeeds.
    context.read<UpdateCourseCubit>().updateCourseState(
          courseEntity: _copyCourseWithState(nextState),
        );
  }

  CourseEntity _copyCourseWithState(String state) {
    return CourseEntity(
      id: course.id,
      state: state,
      posterUrl: course.posterUrl,
      studentsCount: course.studentsCount,
      subject: course.subject,
      level: course.level,
      title: course.title,
      description: course.description,
      price: course.price,
      language: course.language,
      postedDate: course.postedDate,
      contentcreaterentity: course.contentcreaterentity,
    );
  }
}

class _ActionsLayout extends StatelessWidget {
  const _ActionsLayout({
    required this.isArchived,
    required this.onEdit,
    required this.onArchiveOrRestore,
  });

  final bool isArchived;
  final VoidCallback onEdit;
  final VoidCallback onArchiveOrRestore;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final textStyles = AppTextStyles(context);

    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: BlocSelector<UpdateCourseCubit, UpdateCourseState, bool>(
            selector: (state) =>
                state is UpdateCourseStateLoading ||
                state is UpdateCourseLoading ||
                state is UpdateCourseCubitAssetLoading,
            builder: (context, isBusy) => FilledButton.icon(
              onPressed: isBusy ? null : onEdit,
              icon: const Icon(Icons.edit_note, color: Colors.white),
              label: Text(
                LocaleKeys.editCourse,
                style: textStyles.semiBold14.copyWith(color: Colors.white),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: double.infinity,
          child: BlocSelector<UpdateCourseCubit, UpdateCourseState, bool>(
            selector: (state) => state is UpdateCourseStateLoading,
            builder: (context, isStateUpdateLoading) => OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                side: BorderSide.none,
                foregroundColor: isArchived ? Colors.green : colors.error,
              ),
              onPressed: isStateUpdateLoading ? null : onArchiveOrRestore,
              icon: isStateUpdateLoading
                  ? SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: isArchived ? Colors.green : colors.error,
                      ),
                    )
                  : Icon(
                      isArchived
                          ? Icons.unarchive_outlined
                          : Icons.archive_outlined,
                    ),
              label: Text(
                isArchived
                    ? LocaleKeys.restoreCourse
                    : LocaleKeys.archiveCourse,
                style: textStyles.semiBold14,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

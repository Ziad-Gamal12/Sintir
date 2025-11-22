import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/utils/Backend_EndPoints.dart';
import 'package:sintir/Core/widgets/AwesomeDialog.dart';
import 'package:sintir/Core/widgets/CustomButton.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/UpdateCourseCubit/Update_Course_Cubit.dart';

class CourseActionButton extends StatelessWidget {
  const CourseActionButton({
    super.key,
    required this.courseEntity,
  });

  final CourseEntity courseEntity;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<UpdateCourseCubit, UpdateCourseState, bool>(
      selector: (state) => state is UpdateCourseStateLoading,
      builder: (context, isLoading) {
        if (isLoading) {
          return Center(
            child: SizedBox(
              height: 35,
              width: 35,
              child: CircularProgressIndicator(
                  color: _getButtonColor(), strokeWidth: 3),
            ),
          );
        }

        return Custombutton(
          text: _getButtonText(),
          color: _getButtonColor(),
          textColor: Colors.white,
          onPressed: () {
            if (_isCourseDeleted()) {
              _onTap(context);
            } else {
              warningdialog(
                context,
                "يرجى العلم أنه لن يتم حذف الدورة، ولكن سيتم إخفاؤها فقط.",
                () => _onTap(context),
              ).show();
            }
          },
        );
      },
    );
  }

  // ---- Helpers ----

  bool _isCourseDeleted() =>
      courseEntity.state == BackendEndpoints.courseDeletedState;

  String _getButtonText() => _isCourseDeleted() ? "استعادة" : "حذف";

  Color _getButtonColor() => _isCourseDeleted() ? Colors.green : Colors.red;

  void _onTap(BuildContext context) {
    courseEntity.state = _isCourseDeleted()
        ? BackendEndpoints.coursePublishedState
        : BackendEndpoints.courseDeletedState;

    context.read<UpdateCourseCubit>().updateCourseState(
          courseEntity: courseEntity,
        );
  }
}

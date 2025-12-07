import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestEntity.dart';
import 'package:sintir/Core/helper/ShowSnackBar.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddExamWidgets/ExamDetailsWidgets/CustomAddExamDetailsPageViewStep.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TestConsequencesViewWidgets/UpdateTestInfoBottomSheet/UpdateTestInfoBottomSheetActionButton.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/update_test_cubit/update_test_cubit.dart';
import 'package:sintir/locale_keys.dart';

class UpdateTestInfoBottomSheet extends StatefulWidget {
  const UpdateTestInfoBottomSheet(
      {super.key,
      required this.coursetestentity,
      required this.sectionId,
      required this.courseId});
  final CourseTestEntity coursetestentity;
  final String sectionId;
  final String courseId;
  @override
  State<UpdateTestInfoBottomSheet> createState() =>
      _UpdateTestInfoBottomSheetState();
}

class _UpdateTestInfoBottomSheetState extends State<UpdateTestInfoBottomSheet> {
  GlobalKey<FormState> examDetailsFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdateTestCubit, UpdateTestState>(
      listener: (context, state) {
        if (state is UpdateTestItemSuccess) {
          CustomSnackBar.show(context,
              message: LocaleKeys.operationSuccessful, type: SnackType.success);
          Navigator.pop(context);
        } else if (state is UpdateTestItemFailure) {
          CustomSnackBar.show(context,
              message: state.errMessage, type: SnackType.error);
        }
      },
      child: IntrinsicHeight(
        child: Column(
          children: [
            CustomExamDetailsPageViewStep(
                coursetestentity: widget.coursetestentity,
                examDetailsFormKey: examDetailsFormKey),
            const SizedBox(
              height: 42,
            ),
            UpdateTestInfoBottomSheetActionButton(
              courseTestEntity: widget.coursetestentity,
              examDetailsFormKey: examDetailsFormKey,
              sectionId: widget.sectionId,
              courseId: widget.courseId,
            ),
            const SizedBox(
              height: 42,
            ),
          ],
        ),
      ),
    );
  }
}

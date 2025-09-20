import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/CourseReportsCubit/course_reports_cubit.dart';
import 'package:sintir/Core/entities/BottomSheetNavigationRequirmentsEntity.dart';
import 'package:sintir/Core/widgets/AwesomeDialog.dart';
import 'package:sintir/Core/widgets/CustomButton.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseReportsItemEntity.dart';
import 'package:sintir/constant.dart';

class SendcoursereportviewbodyActionButton extends StatelessWidget {
  const SendcoursereportviewbodyActionButton({
    super.key,
    required this.requirmentsEntity,
    required this.formKey,
  });

  final DisplayCourseBottomsheetNavigationRequirmentsEntity requirmentsEntity;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<CourseReportsCubit, CourseReportsState, bool>(
      selector: (state) {
        return state is CourseReportsAddReportLoading;
      },
      builder: (context, state) {
        if (state == true) {
          return const Center(
              child: CircularProgressIndicator(
            color: KSecondaryColor,
          ));
        }
        return Custombutton(
            text: "ارسال الأبلاغ",
            color: KSecondaryColor,
            textColor: Colors.white,
            onPressed: () {
              if (requirmentsEntity.isSubscribed) {
                if (formKey.currentState!.validate()) {
                  formKey.currentState!.save();
                  context.read<CourseReportsCubit>().addCourseReport(
                      courseId: requirmentsEntity.course.id,
                      reportEntity: context.read<CourseReportEntity>());
                }
              } else {
                errordialog(context, "يجب الاشتراك في الدورة لارسال الابلاغ")
                    .show();
              }
            });
      },
    );
  }
}

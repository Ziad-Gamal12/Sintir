import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/CourseReportsCubit/course_reports_cubit.dart';
import 'package:sintir/Core/entities/BottomSheetNavigationRequirmentsEntity.dart';
import 'package:sintir/Core/helper/ShowSnackBar.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/CustomButton.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/domain/Entities/SendCourseReportEntity.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/domain/Entities/report_enums.dart';
import 'package:sintir/locale_keys.dart';

class SendcoursereportviewbodyActionButton extends StatelessWidget {
  const SendcoursereportviewbodyActionButton(
      {super.key,
      required this.requirmentsEntity,
      this.reportType,
      required this.controller,
      required this.formKey});
  final DisplayCourseBottomsheetNavigationRequirmentsEntity requirmentsEntity;
  final ReportType? reportType;
  final TextEditingController controller;
  final GlobalKey<FormState> formKey;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textStyles = AppTextStyles(context);
    final localeCode = Localizations.localeOf(context).languageCode;
    return BlocBuilder<CourseReportsCubit, CourseReportsState>(
        builder: (context, state) {
      return Custombutton(
          onPressed: state is CourseReportsAddReportLoading
              ? () {}
              : () {
                  if (!requirmentsEntity.isSubscribed) {
                    CustomSnackBar.show(context,
                        message: LocaleKeys.mustSubscribeToReport,
                        type: SnackType.error);
                    return;
                  }
                  if (reportType == null || !formKey.currentState!.validate()) {
                    return;
                  }
                  context.read<CourseReportsCubit>().addCourseReport(
                          reportEntity: SendCourseReportEntity(
                        courseId: requirmentsEntity.course.id,
                        type: reportType!,
                        description: controller.text.trim(),
                      ));
                },
          textColor: Colors.white,
          text: "",
          color: theme.primaryColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (state is CourseReportsAddReportLoading)
                SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                )
              else
                Transform.rotate(
                    angle: localeCode != 'ar' ? 3.14 : 0,
                    child: Icon(Icons.send, size: 16, color: Colors.white)),
              SizedBox(width: 8),
              Text(LocaleKeys.submitReport,
                  style: textStyles.semiBold16.copyWith(color: Colors.white)),
            ],
          ));
    });
  }
}

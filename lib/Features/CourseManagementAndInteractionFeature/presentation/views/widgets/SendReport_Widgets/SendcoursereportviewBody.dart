import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/CourseReportsCubit/course_reports_cubit.dart';
import 'package:sintir/Core/entities/BottomSheetNavigationRequirmentsEntity.dart';
import 'package:sintir/Core/helper/ShowSnackBar.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/domain/Entities/report_enums.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/presentation/views/widgets/SendReport_Widgets/CustomHeader.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/presentation/views/widgets/SendReport_Widgets/ReportReasonsAdaptiveSection.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/presentation/views/widgets/SendReport_Widgets/SendCourseReportHeader.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/presentation/views/widgets/SendReport_Widgets/SendcoursereportviewbodyActionButton.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/presentation/views/widgets/SendReport_Widgets/SendcoursereportviewbodyTextField.dart';
import 'package:sintir/constant.dart';
import 'package:sintir/locale_keys.dart';

class Sendcoursereportviewbody extends StatefulWidget {
  const Sendcoursereportviewbody({super.key, required this.requirmentsEntity});
  final DisplayCourseBottomsheetNavigationRequirmentsEntity requirmentsEntity;
  @override
  State<Sendcoursereportviewbody> createState() =>
      _SendcoursereportviewbodyState();
}

class _SendcoursereportviewbodyState extends State<Sendcoursereportviewbody> {
  final _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  ReportType? _type;
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CourseReportsCubit, CourseReportsState>(
      listener: (context, state) {
        if (state is CourseReportsAddReportSuccess) {
          _controller.clear();
          _formKey.currentState?.reset();
          CustomSnackBar.show(context,
              message: LocaleKeys.reportSentSuccessfully,
              type: SnackType.success);
          Navigator.pop(context);
        } else if (state is CourseReportsAddReportFailure) {
          CustomSnackBar.show(context,
              message: state.errMessage, type: SnackType.error);
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: KHorizontalPadding, vertical: KVerticalPadding),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              SendCourseReportHeader(),
              const SizedBox(height: 16),
              CustomHeader(title: LocaleKeys.reportReasons),
              const SizedBox(height: 12),
              ReportReasonsAdaptiveSection(
                  onSelected: (reportReason) =>
                      setState(() => _type = reportReason.type)),
              const SizedBox(height: 24),
              CustomHeader(title: LocaleKeys.reportDescription),
              const SizedBox(height: 12),
              SendcoursereportviewbodyTextField(
                controller: _controller,
              ),
              const SizedBox(height: 20),
              SendcoursereportviewbodyActionButton(
                requirmentsEntity: widget.requirmentsEntity,
                reportType: _type,
                controller: _controller,
                formKey: _formKey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/CourseReportsCubit/course_reports_cubit.dart';
import 'package:sintir/Core/entities/BottomSheetNavigationRequirmentsEntity.dart';
import 'package:sintir/Core/helper/ShowSnackBar.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/domain/Entities/SendCourseReportEntity.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/domain/Entities/report_enums.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/presentation/views/widgets/SendReport_Widgets/CustomHeader.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/presentation/views/widgets/SendReport_Widgets/SendReportReasonsGridView.dart';
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
              CustomHeader(title: LocaleKeys.reportReasons),
              const SizedBox(height: 12),
              Sendreportreasonsgridview(
                  groupValue: _type,
                  onChange: (value) => setState(() => _type = value)),
              const SizedBox(height: 24),
              CustomHeader(title: LocaleKeys.reportDescription),
              const SizedBox(height: 12),
              TextFormField(
                controller: _controller,
                minLines: 4,
                maxLines: 6,
                maxLength: 500,
                textInputAction: TextInputAction.newline,
                decoration: InputDecoration(
                    hintText: LocaleKeys.hintWriteMessage,
                    alignLabelWithHint: true),
                validator: (value) {
                  final text = value?.trim() ?? '';
                  if (text.length < 10)
                    return LocaleKeys.reportDescriptionTooShort;
                  if (text.length > 500)
                    return LocaleKeys.reportDescriptionTooLong;
                  return null;
                },
              ),
              const SizedBox(height: 20),
              BlocBuilder<CourseReportsCubit, CourseReportsState>(
                  builder: (context, state) {
                final loading = state is CourseReportsAddReportLoading;
                return FilledButton(
                  onPressed: loading
                      ? null
                      : () {
                          if (!widget.requirmentsEntity.isSubscribed) {
                            CustomSnackBar.show(context,
                                message: LocaleKeys.mustSubscribeToReport,
                                type: SnackType.error);
                            return;
                          }
                          if (_type == null ||
                              !_formKey.currentState!.validate()) {
                            return;
                          }
                          context.read<CourseReportsCubit>().addCourseReport(
                                  reportEntity: SendCourseReportEntity(
                                courseId: widget.requirmentsEntity.course.id,
                                type: _type!,
                                description: _controller.text.trim(),
                              ));
                        },
                  style: FilledButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                      foregroundColor:
                          Theme.of(context).colorScheme.onSecondary),
                  child: loading
                      ? const SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(strokeWidth: 2))
                      : Text(LocaleKeys.submitReport),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/CourseReportsCubit/course_reports_cubit.dart';
import 'package:sintir/Core/entities/BottomSheetNavigationRequirmentsEntity.dart';
import 'package:sintir/Core/helper/ShowSnackBar.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseReportsItemEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/SendReport_Widgets/CustomHeader.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/SendReport_Widgets/SendReportReasonsGridView.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/SendReport_Widgets/SendcoursereportviewbodyActionButton.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/SendReport_Widgets/SendcoursereportviewbodyTextField.dart';
import 'package:sintir/locale_keys.dart';

class Sendcoursereportviewbody extends StatefulWidget {
  const Sendcoursereportviewbody({
    super.key,
    required this.requirmentsEntity,
  });

  final DisplayCourseBottomsheetNavigationRequirmentsEntity requirmentsEntity;

  @override
  State<Sendcoursereportviewbody> createState() =>
      _SendcoursereportviewbodyState();
}

class _SendcoursereportviewbodyState extends State<Sendcoursereportviewbody> {
  String reportReson = "";
  TextEditingController controller = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CourseReportsCubit, CourseReportsState>(
      listener: (context, state) {
        if (state is CourseReportsAddReportSuccess) {
          CustomSnackBar.show(
            context,
            message: LocaleKeys.reportSentSuccessfully,
            type: SnackType.success,
          );
          Navigator.pop(context);
        } else if (state is CourseReportsAddReportFailure) {
          CustomSnackBar.show(
            context,
            message: state.errMessage,
            type: SnackType.error,
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 20),
        child: Form(
          key: formKey,
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: CustomHeader(title: LocaleKeys.reportReasons),
              ),
              Sendreportreasonsgridview(
                groupValue: reportReson,
                onChange: (value) {
                  reportReson = value.toString();
                  context.read<CourseReportEntity>().type = reportReson;
                  setState(() {});
                },
              ),
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    CustomHeader(title: LocaleKeys.reportDescription),
                    const SizedBox(
                      height: 20,
                    ),
                    const SendcoursereportviewbodyTextField(),
                    const Spacer(),
                    SendcoursereportviewbodyActionButton(
                        requirmentsEntity: widget.requirmentsEntity,
                        formKey: formKey)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

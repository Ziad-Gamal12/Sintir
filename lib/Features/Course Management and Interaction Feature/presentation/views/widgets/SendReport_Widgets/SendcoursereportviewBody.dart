import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sintir/Core/Managers/Cubits/CourseReportsCubit/course_reports_cubit.dart';
import 'package:sintir/Core/entities/BottomSheetNavigationRequirmentsEntity.dart';
import 'package:sintir/Core/widgets/AwesomeDialog.dart';
import 'package:sintir/Core/widgets/CustomButton.dart';
import 'package:sintir/Core/widgets/CustomTextFields/CustomTeaxtField.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseReportsItemEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/SendReport_Widgets/CustomHeader.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/SendReport_Widgets/SendReportReasonsGridView.dart';
import 'package:sintir/constant.dart';

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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 20),
      child: Form(
        key: formKey,
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(
              child: CustomHeader(title: "أسباب الابلاغ :"),
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
                  const CustomHeader(title: "وصف الابلاغ :"),
                  const SizedBox(
                    height: 20,
                  ),
                  Customteaxtfield(
                      maxLines: 4,
                      hintText: "اكتب ملاحظتك هنا ....",
                      obscureText: false,
                      onSaved: (val) {
                        context.read<CourseReportEntity>().description =
                            val ?? "";
                      },
                      textInputType: TextInputType.text,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "لا يمكن ان يكون الحقل فارغ";
                        }
                        return null;
                      }),
                  const Spacer(),
                  Custombutton(
                      text: "ارسال الأبلاغ",
                      color: KSecondaryColor,
                      textColor: Colors.white,
                      onPressed: () {
                        if (widget.requirmentsEntity.isSubscribed) {
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();
                            context.read<CourseReportsCubit>().addCourseReport(
                                courseId: widget.requirmentsEntity.course.id,
                                reportEntity:
                                    context.read<CourseReportEntity>());
                          }
                        } else {
                          errordialog(context,
                                  "يجب الاشتراك في الدورة لارسال الابلاغ")
                              .show();
                        }
                      })
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

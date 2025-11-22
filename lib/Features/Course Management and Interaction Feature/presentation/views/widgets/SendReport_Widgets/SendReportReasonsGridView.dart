import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/CustomRadioWidget.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/SendCourseReportEntity.dart';

class Sendreportreasonsgridview extends StatelessWidget {
  const Sendreportreasonsgridview(
      {super.key, required this.onChange, required this.groupValue});
  final ValueChanged<String?> onChange;
  final String groupValue;
  @override
  Widget build(BuildContext context) {
    return SliverGrid.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 90 / 20,
            crossAxisCount: 2,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20),
        itemCount: Sendcoursereportentity.reportReasons.length,
        itemBuilder: (context, index) {
          return Row(
            children: [
              CustomRadioWidget(
                  value: Sendcoursereportentity.reportReasons[index].title,
                  onchange: onChange,
                  groupValue: groupValue),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: Text(
                  Sendcoursereportentity.reportReasons[index].title,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles(context)
                      .semiBold12
                      .copyWith(color: Colors.black),
                ),
              )
            ],
          );
        });
  }
}

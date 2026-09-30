import 'package:flutter/material.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/domain/Entities/report_enums.dart';
import 'package:sintir/locale_keys.dart';

class Sendreportreasonsgridview extends StatelessWidget {
  const Sendreportreasonsgridview(
      {super.key, required this.onChange, required this.groupValue});
  final ValueChanged<ReportType?> onChange;
  final ReportType? groupValue;

  String _label(ReportType type) => switch (type) {
        ReportType.inappropriateContent => LocaleKeys.reportInappropriate,
        ReportType.misleadingInfo => LocaleKeys.reportMisleading,
        ReportType.incorrectInfo => LocaleKeys.reportWrongInfo,
        ReportType.other => LocaleKeys.reportOther,
      };

  @override
  Widget build(BuildContext context) => GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        childAspectRatio: 3.1,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        children: ReportType.values.map((type) {
          final selected = groupValue == type;
          return ChoiceChip(
            label: Text(_label(type),
                style: Theme.of(context).textTheme.labelMedium),
            selected: selected,
            onSelected: (_) => onChange(type),
            showCheckmark: true,
          );
        }).toList(),
      );
}

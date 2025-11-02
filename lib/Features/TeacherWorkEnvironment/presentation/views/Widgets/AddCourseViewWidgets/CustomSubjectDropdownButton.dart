import 'package:flutter/material.dart';
import 'package:sintir/Core/widgets/CustomAnimatedDropDownButton.dart';

class CustomSubjectDropdownButton extends StatefulWidget {
  const CustomSubjectDropdownButton({super.key, required this.onValueChange});
  final ValueChanged<String?> onValueChange;
  @override
  State<CustomSubjectDropdownButton> createState() =>
      _CustomSubjectDropdownButtonState();
}

class _CustomSubjectDropdownButtonState
    extends State<CustomSubjectDropdownButton> {
  List<String> items = [
    "اللغة العربية",
    "اللغة الانجليزية",
    "اللغة الفرنسية",
    "اللغة الايطالية",
    "اللغة الاسبانية",
    "الرياضيات",
    "الفيزياء",
    "الكيمياء",
    "الاحياء",
    "البيولوجيا",
    "العلوم",
    "الفلسفة",
    "التاريخ",
    "الجغرافيا",
    "علوم الحاسب"
        "أخرى"
  ];
  @override
  Widget build(BuildContext context) {
    return CustomAnimatedDropDownButton(
      items: items,
      hintText: "الماده الدراسية",
      onChanged: widget.onValueChange,
    );
  }
}

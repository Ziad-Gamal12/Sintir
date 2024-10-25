// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';

class StudentsignupBirthdayfield extends StatefulWidget {
  const StudentsignupBirthdayfield(
      {super.key, required this.width, required this.birhdaydate});
  final double width;
  final ValueChanged<DateTime> birhdaydate;
  @override
  State<StudentsignupBirthdayfield> createState() =>
      _StudentsignupBirthdayfieldState();
}

class _StudentsignupBirthdayfieldState
    extends State<StudentsignupBirthdayfield> {
  DateTime? pickedDate;
  showdatepicker() {
    showDatePicker(
            context: context,
            firstDate: DateTime(2000),
            lastDate: DateTime(2025))
        .then((value) {
      widget.birhdaydate(value!);
      setState(() {
        pickedDate = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showdatepicker();
      },
      child: Container(
        height: 56,
        width: widget.width,
        decoration: BoxDecoration(
            color: const Color(0xffF9FAFA),
            borderRadius: BorderRadius.circular(4)),
        child: ListTile(
          title: Text(
            pickedDate == null
                ? "تاريخ الميلاد"
                : "${pickedDate!.day}/${pickedDate!.month}/${pickedDate!.year}",
            style: AppTextStyles.bold14Auto.copyWith(
                color: pickedDate == null
                    ? const Color(0xffAEAEB2)
                    : Colors.grey.shade700),
          ),
          leading: const Icon(
            Icons.date_range_outlined,
            color: Color(0xffAEAEB2),
          ),
        ),
      ),
    );
  }
}

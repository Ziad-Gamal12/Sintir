// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/Auth/Domain/Entities/UserEntity.dart';

class StudentsignupBirthdayfield extends StatefulWidget {
  const StudentsignupBirthdayfield({
    super.key,
  });
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
      firstDate: DateTime(1990),
      lastDate: DateTime(2025),
      initialEntryMode: DatePickerEntryMode.calendar,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.blue,
              onPrimary: Colors.white,
              onSurface: Colors.black87,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFF4E7EFF), // Buttons color
                textStyle: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
            ),
            dialogTheme: const DialogThemeData(backgroundColor: Colors.white),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(18), // Premium rounded corners
            child: child!,
          ),
        );
      },
    ).then((value) {
      if (!mounted) return;
      context.read<UserEntity>().studentExtraDataEntity?.birthDate =
          value.toString();
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
        width: double.infinity,
        decoration: BoxDecoration(
            color: const Color(0xffF9FAFA),
            borderRadius: BorderRadius.circular(12)),
        child: ListTile(
          title: Text(
            pickedDate == null
                ? "تاريخ  الميلاد"
                : "${pickedDate!.day}/${pickedDate!.month}/${pickedDate!.year}",
            style: AppTextStyles(context).bold14.copyWith(
                color: pickedDate == null
                    ? const Color(0xffAEAEB2)
                    : Colors.grey.shade700),
          ),
          leading: const Icon(
            Icons.date_range_outlined,
            color: Color(0xFF6C6C70),
          ),
        ),
      ),
    );
  }
}

// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/Auth/Domain/Entities/UserEntity.dart';
import 'package:sintir/locale_keys.dart';

class StudentsignupBirthdayfield extends StatefulWidget {
  const StudentsignupBirthdayfield({super.key});

  @override
  State<StudentsignupBirthdayfield> createState() =>
      _StudentsignupBirthdayfieldState();
}

class _StudentsignupBirthdayfieldState
    extends State<StudentsignupBirthdayfield> {
  DateTime? pickedDate;

  void showdatepicker() {
    showDatePicker(
      context: context,
      firstDate: DateTime(1990),
      lastDate: DateTime.now(),
      initialEntryMode: DatePickerEntryMode.calendar,
      builder: (context, child) {
        final theme = Theme.of(context);
        final isDark = theme.brightness == Brightness.dark;

        return Theme(
          data: theme.copyWith(
            colorScheme: isDark
                ? const ColorScheme.dark(
                    primary: Color(0xFF4E7EFF),
                    onPrimary: Colors.white,
                    onSurface: Colors.white70,
                  )
                : const ColorScheme.light(
                    primary: Color(0xFF4E7EFF),
                    onPrimary: Colors.white,
                    onSurface: Colors.black87,
                  ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFF4E7EFF),
                textStyle: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
            ),
            dialogTheme: DialogThemeData(
              backgroundColor: isDark ? const Color(0xFF1F1F1F) : Colors.white,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: child!,
          ),
        );
      },
    ).then((value) {
      if (!mounted) return;

      if (value != null) {
        context.read<UserEntity>().studentExtraDataEntity?.birthDate = value;
      }

      setState(() {
        pickedDate = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    // Match CustomTextField styling exactly.
    final Color fillBg = isDarkMode
        ? Colors.white.withValues(alpha: 0.05)
        : const Color(0xFFF8F9FA);

    final Color borderColor = isDarkMode
        ? Colors.white10
        : const Color(0xFFE4E6E8);

    final bool hasDate = pickedDate != null;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: showdatepicker,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          height: 56,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: fillBg,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: borderColor, width: 1),
          ),
          child: Row(
            children: [
              Icon(
                Icons.date_range_outlined,
                size: 20,
                color: theme.primaryColor.withValues(alpha: 0.7),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  hasDate
                      ? '${pickedDate!.day}/${pickedDate!.month}/${pickedDate!.year}'
                      : LocaleKeys.studentBirthDate,
                  style: hasDate
                      ? AppTextStyles(context).semiBold14.copyWith(
                          color: theme.textTheme.bodyLarge?.color,
                        )
                      : AppTextStyles(context).regular14.copyWith(
                          color: theme.hintColor.withValues(alpha: 0.5),
                        ),
                ),
              ),
              Icon(
                Icons.keyboard_arrow_down_rounded,
                size: 20,
                color: theme.hintColor.withValues(alpha: 0.6),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

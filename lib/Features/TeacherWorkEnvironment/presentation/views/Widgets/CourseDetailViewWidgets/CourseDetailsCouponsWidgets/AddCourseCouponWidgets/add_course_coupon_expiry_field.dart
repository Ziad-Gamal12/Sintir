import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';

class AddCourseCouponExpiryField extends StatelessWidget {
  final DateTime? pickedDate;
  final VoidCallback onTap;

  const AddCourseCouponExpiryField({
    super.key,
    required this.pickedDate,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 56,
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xffF9FAFA),
          borderRadius: BorderRadius.circular(4),
        ),
        child: ListTile(
          title: Text(
            pickedDate == null
                ? "تاريخ الانتهاء"
                : "${pickedDate!.day}/${pickedDate!.month}/${pickedDate!.year}",
            style: AppTextStyles(context).bold14.copyWith(
                  color: pickedDate == null
                      ? const Color(0xffAEAEB2)
                      : Colors.grey.shade700,
                ),
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

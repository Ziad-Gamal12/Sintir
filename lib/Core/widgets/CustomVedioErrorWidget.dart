import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';

class CustomVedioErrorWidget extends StatelessWidget {
  const CustomVedioErrorWidget({
    super.key,
    required this.errorMessage,
  });
  final String? errorMessage;
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(12)),
        child: Text(
          errorMessage ?? "حدث خطأ ما! يرجى اعادة المحاولة",
          style:
              AppTextStyles(context).semiBold16.copyWith(color: Colors.black),
        ));
  }
}

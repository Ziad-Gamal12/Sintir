import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';

class CustomSendNoteWidgetBodyHeader extends StatelessWidget {
  const CustomSendNoteWidgetBodyHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.orange.withOpacity(.1),
          ),
          padding: const EdgeInsets.all(8),
          child: const Icon(
            Icons.question_mark_rounded,
            color: Colors.black,
          ),
        ),
        const SizedBox(
          width: 12,
        ),
        Text(
          "ارسال ملاحظه",
          style: AppTextStyles(context).semiBold20.copyWith(
                color: Colors.black,
              ),
        ),
      ],
    );
  }
}

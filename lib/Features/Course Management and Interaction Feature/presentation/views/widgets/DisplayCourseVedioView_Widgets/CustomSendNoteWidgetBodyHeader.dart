import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';

class CustomSendNoteWidgetBodyHeader extends StatelessWidget {
  const CustomSendNoteWidgetBodyHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      "ارسال ملاحظه",
      style: AppTextStyles(context).bold20.copyWith(
            color: Colors.black,
          ),
    );
  }
}

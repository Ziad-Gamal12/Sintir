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
      style: AppTextStyles.bold20Auto.copyWith(
        color: Colors.black,
      ),
    );
  }
}

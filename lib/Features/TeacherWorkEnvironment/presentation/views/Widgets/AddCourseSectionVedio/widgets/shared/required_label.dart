import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';

class RequiredLabel extends StatelessWidget {
  const RequiredLabel({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final style = AppTextStyles(context).bold14;
    final errorColor = Theme.of(context).colorScheme.error;
    return Text.rich(
      TextSpan(
        text: text,
        style: style,
        children: [
          TextSpan(text: ' *', style: style.copyWith(color: errorColor)),
        ],
      ),
    );
  }
}

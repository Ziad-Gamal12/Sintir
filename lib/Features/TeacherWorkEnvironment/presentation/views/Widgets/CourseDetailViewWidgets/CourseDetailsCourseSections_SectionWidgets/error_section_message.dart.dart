import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';

class ErrorSectionMessage extends StatelessWidget {
  const ErrorSectionMessage({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        message,
        style: AppTextStyles(context).regular14.copyWith(color: Colors.red),
      ),
    );
  }
}

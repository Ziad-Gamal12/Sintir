import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/locale_keys.dart';

class CustomVideoControllerErrorWidget extends StatelessWidget {
  CustomVideoControllerErrorWidget({
    super.key,
  });

  final String errorMessage = LocaleKeys.videoError;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(16),
      child: Card(
        color: Colors.transparent.withOpacity(0.2),
        child: Text(
          errorMessage,
          style: AppTextStyles(context)
              .regular16
              .copyWith(color: Colors.red.shade500),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

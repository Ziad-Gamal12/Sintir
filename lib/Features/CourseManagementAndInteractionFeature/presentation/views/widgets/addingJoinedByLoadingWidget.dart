// ignore_for_file: camel_case_types, file_names

import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/constant.dart';
import 'package:sintir/locale_keys.dart';

class addingJoinedByLoadingWidget extends StatelessWidget {
  const addingJoinedByLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 4,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 24,
            width: 24,
            child: CircularProgressIndicator(
              color: KMainColor,
              strokeWidth: 2.5,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              LocaleKeys.loggingIn,
              style:
                  AppTextStyles(context).semiBold16.copyWith(color: KMainColor),
            ),
          ),
        ],
      ),
    );
  }
}

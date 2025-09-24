// ignore_for_file: camel_case_types, file_names

import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/constant.dart';

class addingJoinedByLoadingWidget extends StatelessWidget {
  const addingJoinedByLoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
        children: [
          const CircularProgressIndicator(
            color: KMainColor,
          ),
          const SizedBox(
            width: 4,
          ),
          Text(
            "جارى تسجيل دخولك",
            style: AppTextStyles.semiBold16.copyWith(color: KMainColor),
          )
        ],
      ),
    );
  }
}

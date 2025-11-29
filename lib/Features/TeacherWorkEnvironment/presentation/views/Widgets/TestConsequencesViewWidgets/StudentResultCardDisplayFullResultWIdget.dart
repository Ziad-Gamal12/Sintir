import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/TestResulteEntity.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/ReviewTestResultView.dart';
import 'package:sintir/constant.dart';
import 'package:sintir/locale_keys.dart';

class StudentResultCardAction extends StatelessWidget {
  const StudentResultCardAction({super.key, required this.testResultEntity});
  final TestResultEntity testResultEntity;

  @override
  Widget build(BuildContext context) {
    final style = AppTextStyles(context);

    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        GoRouter.of(context)
            .push(Reviewtestresultview.routeName, extra: testResultEntity);
      },
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: KMainColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.visibility_rounded, color: KMainColor, size: 22),
            const SizedBox(width: 6),
            Text(
              LocaleKeys.viewResult,
              style: style.regular14.copyWith(color: KMainColor),
            ),
          ],
        ),
      ),
    );
  }
}

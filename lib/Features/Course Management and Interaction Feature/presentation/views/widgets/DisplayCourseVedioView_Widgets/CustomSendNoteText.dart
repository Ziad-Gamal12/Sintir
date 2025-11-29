// ignore_for_file: must_be_immutable, file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseVideoItemEntities/CourseVideoviewnavigationsrequirmentsentity.dart';
import 'package:sintir/Core/utils/Variables.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/DisplayCourseVedioView_Widgets/CustomSendNoteWidget.dart';
import 'package:sintir/constant.dart';
import 'package:sintir/locale_keys.dart';

class CustomSendNoteText extends StatelessWidget {
  const CustomSendNoteText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Variables.DisplaycoursevedioveiwScaffoldKey.currentState!
            .showBottomSheet((context1) {
          return CustomSendNoteWidget(
            coursevideoviewnavigationsrequirmentsentity:
                context.read<CourseVideoViewNavigationsRequirmentsEntity>(),
          );
        });
      },
      child: Text.rich(TextSpan(children: [
        TextSpan(
            text: " ${LocaleKeys.facedSomeIssues}  ",
            style:
                AppTextStyles(context).regular13.copyWith(color: Colors.black)),
        TextSpan(
            text: LocaleKeys.sendNote,
            style:
                AppTextStyles(context).bold13.copyWith(color: KSecondaryColor))
      ])),
    );
  }
}

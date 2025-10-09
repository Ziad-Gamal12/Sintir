// ignore_for_file: camel_case_types, file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sintir/Core/Managers/Cubits/CourseSectionsCubit/CourseSectionsCubit.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/constant.dart';
import 'package:skeletonizer/skeletonizer.dart';

class courseIntroductionViewBodyListViewHeader extends StatelessWidget {
  const courseIntroductionViewBodyListViewHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocSelector<CourseSectionsCubit, CourseSectionsState, bool>(
      selector: (state) {
        return state is GetCourseSectionsLoading;
      },
      builder: (context, state) {
        return Skeletonizer(
          enabled: state,
          child: Row(
            children: [
              const Icon(FontAwesomeIcons.starOfLife,
                  color: KMainColor, size: 20),
              const SizedBox(
                width: 10,
              ),
              Text(
                "محتوى الكورس",
                style: AppTextStyles(context)
                    .semiBold20
                    .copyWith(color: Colors.black),
                textAlign: TextAlign.start,
              ),
            ],
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sintir/Core/Managers/Cubits/CourseSectionsCubit/CourseSectionsCubit.dart';
import 'package:sintir/Core/utils/imageAssets.dart';
import 'package:sintir/Core/widgets/AwesomeDialog.dart';
import 'package:sintir/Core/widgets/customListTileWidget.dart';

class SectionHeaderTile extends StatelessWidget {
  const SectionHeaderTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onTap,
    required this.courseId,
    required this.sectionId,
  });

  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final String courseId, sectionId;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Customlisttilewidget(
          title: title,
          subtitle: subtitle,
          image: Assets.assetsIconsSVGIconsSectionIcon,
          trailing: IconButton(
            onPressed: () {
              warningdialog(context, "هل أنت متاكد من حذف القسم", () {
                context.read<CourseSectionsCubit>().deleteSection(
                      courseId: courseId,
                      sectionId: sectionId,
                    );
              }).show();
            },
            icon: const Icon(FontAwesomeIcons.trashCan),
          ),
        ),
      ),
    );
  }
}

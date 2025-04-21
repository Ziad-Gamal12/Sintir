import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/entities/BottomSheetNavigationRequirmentsEntity.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/customListTileWidget.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseSectionEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseVedioItemEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseVideoviewnavigationsrequirmentsentity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CustomContainerSectionItem.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CustomUnAvilableSectionWidget.dart';

class CustomVedioListViewItem extends StatelessWidget {
  const CustomVedioListViewItem(
      {super.key, required this.item, required this.section});
  final Coursevedioitementity item;
  final CourseSectionEntity section;
  @override
  Widget build(BuildContext context) {
    bool isAvilabe =
        context.read<Bottomsheetnavigationrequirmentsentity>().isSubscribed;
    return GestureDetector(
      onTap: () => isAvilabe
          ? item.ontap(
              context: context,
              requires: Coursevideoviewnavigationsrequirmentsentity(
                  sectionId: section.id,
                  courseEntity: context
                      .read<Bottomsheetnavigationrequirmentsentity>()
                      .course,
                  video: item),
              course:
                  context.read<Bottomsheetnavigationrequirmentsentity>().course)
          : null,
      child: Stack(
        children: [
          Customcontainersectionitem(
              child: Customlisttilewidget(
            title: item.title,
            image: item.preffixImage,
            trailing: Text(
              "${item.durationTime} دقائق",
              style: AppTextStyles.regular11
                  .copyWith(color: const Color(0xff818181)),
            ),
          )),
          CustomUnAvailableSectionWidget(isAvailable: isAvilabe)
        ],
      ),
    );
  }
}

// ignore_for_file: file_names

import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/CourseSectionsCubit/CourseSectionsCubit.dart';
import 'package:sintir/Core/entities/BottomSheetNavigationRequirmentsEntity.dart';
import 'package:sintir/Core/utils/imageAssets.dart';
import 'package:sintir/Core/widgets/customListTileWidget.dart';
import 'package:sintir/Core/widgets/showSnackBar.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CoursSectionsListItemEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CustomSectionListView.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CustomContentListViewitem extends StatelessWidget {
  CustomContentListViewitem({
    super.key,
    required this.sectionItem,
  });
  final CourseSectionEntity sectionItem;
  List sectionItems = [];
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CourseSectionsCubit, CourseSectionsState>(
      listener: (context, state) {
        if (state is GetSectionItemsSuccess) {
          sectionItems = state.items;
        } else if (state is GetSectionItemsFailure) {
          showSnackBar(context, state.errMessage);
        }
      },
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.all(12),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade100,
                blurRadius: 7,
                spreadRadius: 1,
              ),
            ],
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.black, width: .5),
            color: Colors.grey.shade100,
          ),
          child: ExpandablePanel(
            theme: const ExpandableThemeData(),
            header: InkWell(
              onTap: () {
                if (sectionItems.isEmpty) {
                  context.read<CourseSectionsCubit>().getSectionItems(
                      sectionId: sectionItem.id,
                      courseId: context
                          .read<Bottomsheetnavigationrequirmentsentity>()
                          .course
                          .id);
                }
              },
              child: Customlisttilewidget(
                title: sectionItem.title,
                image: Assets.assetsImagesSectionIcon,
                subtitle: sectionItem.subtitle,
              ),
            ),
            collapsed: const SizedBox(),
            expanded: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              //update this by getting the section items list
              child: Skeletonizer(
                enabled: state is GetSectionItemsLoading,
                child: CustomSectionListView(
                  items: sectionItems,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

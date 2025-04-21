import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/CourseSectionsCubit/CourseSectionsCubit.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseSectionEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseTestEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseVedioItemEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CustomFileListViewItem.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CustomTestListViewItem.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CustomVedioListViewItem.dart';

class CustomSectionListView extends StatefulWidget {
  const CustomSectionListView({
    super.key,
    required this.section,
    required this.itemsChanged,
  });
  final CourseSectionEntity section;
  final ValueChanged<List> itemsChanged;

  @override
  State<CustomSectionListView> createState() => _CustomSectionListViewState();
}

class _CustomSectionListViewState extends State<CustomSectionListView> {
  Widget getChild(dynamic item, BuildContext context) {
    if (item is Coursevedioitementity) {
      return CustomVedioListViewItem(
        item: item,
        section: widget.section,
      );
    } else if (item is Coursetestentity) {
      return Customtestlistviewitem(
        item: item,
        section: widget.section,
      );
    } else {
      return Customfilelistviewitem(
        section: widget.section,
        item: item,
      );
    }
  }

  List<dynamic> items = [];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CourseSectionsCubit, CourseSectionsState>(
      builder: (context, state) {
        if (state is GetSectionItemsSuccess &&
            state.sectionId == widget.section.id) {
          items = state.items;
          widget.itemsChanged(items);
        }

        return ListView.builder(
          itemCount: items.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: getChild(items[index], context),
            );
          },
        );
      },
    );
  }
}

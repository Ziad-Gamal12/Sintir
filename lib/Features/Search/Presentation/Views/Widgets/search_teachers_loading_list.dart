import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/ContentCreaterEntity.dart';
import 'package:sintir/Features/Search/Presentation/Views/Widgets/SearchViewBodyTeachersListViewItem.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SearchTeachersLoadingList extends StatelessWidget {
  const SearchTeachersLoadingList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * .1,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: 10,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Skeletonizer(
              enabled: true,
              child: SearchViewBodyTeachersListViewItem(
                contentcreaterentity: Contentcreaterentity.empty(),
              ),
            ),
          );
        },
      ),
    );
  }
}

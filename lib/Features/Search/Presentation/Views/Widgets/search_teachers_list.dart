import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/ContentCreaterEntity.dart';
import 'package:sintir/Features/Search/Presentation/Views/Widgets/SearchViewBodyTeachersListViewItem.dart';

class SearchTeachersList extends StatelessWidget {
  const SearchTeachersList({super.key, required this.teachersList});

  final List<Contentcreaterentity> teachersList;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * .1,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: teachersList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: SearchViewBodyTeachersListViewItem(
              contentcreaterentity: teachersList[index],
            ),
          );
        },
      ),
    );
  }
}

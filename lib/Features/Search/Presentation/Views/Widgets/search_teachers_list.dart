import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/entities/CourseEntities/ContentCreaterEntity.dart';
import 'package:sintir/Features/ContentCreatorProfile/Presentation/Views/ContentCreatorProfile.dart';
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
            child: GestureDetector(
              onTap: () {
                GoRouter.of(context).push(ContentCreatorProfile.routeName,
                    extra: teachersList[index]);
              },
              child: SearchViewBodyTeachersListViewItem(
                contentcreaterentity: teachersList[index],
              ),
            ),
          );
        },
      ),
    );
  }
}

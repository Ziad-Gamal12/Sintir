import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/ContentCreaterEntity.dart';
import 'package:sintir/Features/Search/Presentation/Views/Widgets/SearchViewBodySearchViewBodyTeachersListHeader.dart';
import 'package:sintir/Features/Search/Presentation/Views/Widgets/SearchViewBodyTeachersListView.dart';

class SearchTeachersSection extends StatelessWidget {
  const SearchTeachersSection({super.key, required this.teachers});
  final List<Contentcreaterentity> teachers;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SearchViewBodySearchViewBodyTeachersListHeader(),
        const SizedBox(height: 10),
        SearchTeachersListView(teachersList: teachers),
      ],
    );
  }
}

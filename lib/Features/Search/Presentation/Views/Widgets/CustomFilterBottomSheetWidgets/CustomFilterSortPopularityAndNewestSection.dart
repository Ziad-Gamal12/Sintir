import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sintir/Features/Search/Domain/Entities/CustomFilterEntity.dart';
import 'package:sintir/Features/Search/Presentation/Views/Widgets/CustomFilterBottomSheetWidgets/CustomFilterCheckedBoxItem.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddCourseViewWidgets/CustomEducationLevelDropdownButton.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddCourseViewWidgets/CustomSubjectDropdownButton.dart';
import 'package:sintir/locale_keys.dart';

class CustomFilterMoreFilters extends StatefulWidget {
  const CustomFilterMoreFilters({super.key});

  @override
  State<CustomFilterMoreFilters> createState() =>
      _CustomFilterMoreFiltersState();
}

class _CustomFilterMoreFiltersState extends State<CustomFilterMoreFilters> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CustomFilterCheckedBoxItem(
                onChanged: (value) {
                  context.read<CourseFilterEntity>().sortByPopularity = true;
                },
                title: LocaleKeys.mostViewed),
            CustomFilterCheckedBoxItem(
                onChanged: (value) {
                  context.read<CourseFilterEntity>().sortByNewest = true;
                },
                title: LocaleKeys.latestCourses),
          ],
        ),
        const SizedBox(
          height: 30,
        ),
        CustomEducationLevelDropdownButton(onValueChange: (value) {
          context.read<CourseFilterEntity>().educaionLevel = value;
        }),
        const SizedBox(
          height: 10,
        ),
        CustomSubjectDropdownButton(onValueChange: (value) {
          context.read<CourseFilterEntity>().subject = value;
        }),
      ],
    );
  }
}

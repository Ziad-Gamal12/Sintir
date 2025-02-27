import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/widgets/CustomContentListViewitem.dart';
import 'package:sintir/Core/widgets/CustomEmptyWidget.dart';
import 'package:sintir/Core/widgets/CustomListORGridTextHeader.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CoursSectionsListItemEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/AddCourseSectionView.dart';
import 'package:sintir/constant.dart';

class Coursedetailssectionspageviewitem extends StatelessWidget {
  const Coursedetailssectionspageviewitem(
      {super.key, required this.courseSectionsEntity});
  final List<CoursSectionsListItemEntity> courseSectionsEntity;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            CustomListORGridTextHeader(
              text: "المحتوى",
            ),
            const SizedBox(
              height: 10,
            ),
            courseSectionsEntity.isNotEmpty
                ? ListView.builder(
                    shrinkWrap: true,
                    itemCount: courseSectionsEntity.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return CustomContentListViewitem(
                        sectionItem: courseSectionsEntity[index],
                      );
                    },
                  )
                : const CustomEmptyWidget()
          ],
        ),
        Positioned(
          bottom: 40,
          left: 0,
          right: 0,
          child: InkWell(
            onTap: () {
              GoRouter.of(context).push(Addcoursesectionview.routeName);
            },
            child: const CircleAvatar(
              backgroundColor: KMainColor,
              radius: 35,
              child: Icon(
                Icons.add,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
        )
      ],
    );
  }
}

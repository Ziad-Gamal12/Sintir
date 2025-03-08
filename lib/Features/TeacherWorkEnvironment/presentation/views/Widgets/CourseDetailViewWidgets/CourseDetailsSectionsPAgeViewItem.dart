import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/entities/CourseEntity.dart';
import 'package:sintir/Core/widgets/CustomContentListViewitem.dart';
import 'package:sintir/Core/widgets/CustomEmptyWidget.dart';
import 'package:sintir/Core/widgets/CustomListORGridTextHeader.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/AddCourseSectionView.dart';
import 'package:sintir/constant.dart';

class Coursedetailssectionspageviewitem extends StatelessWidget {
  const Coursedetailssectionspageviewitem(
      {super.key, required this.courseEntity});
  final CourseEntity courseEntity;
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
            courseEntity.coursSectionsListItemEntity!.isNotEmpty
                ? ListView.builder(
                    shrinkWrap: true,
                    itemCount: courseEntity.coursSectionsListItemEntity!.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: CustomContentListViewitem(
                          sectionItem:
                              courseEntity.coursSectionsListItemEntity![index],
                        ),
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
              GoRouter.of(context)
                  .push(Addcoursesectionview.routeName, extra: courseEntity);
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

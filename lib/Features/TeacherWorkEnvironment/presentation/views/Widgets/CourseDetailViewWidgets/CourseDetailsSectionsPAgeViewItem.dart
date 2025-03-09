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
        CustomScrollView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          slivers: [
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 20,
              ),
            ),
            SliverToBoxAdapter(
              child: CustomListORGridTextHeader(
                text: "المحتوى",
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 10,
              ),
            ),
            if (courseEntity.coursSectionsListItemEntity!.isNotEmpty)
              SliverList.builder(
                itemCount: courseEntity.coursSectionsListItemEntity!.length,
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
            else
              const SliverToBoxAdapter(child: CustomEmptyWidget())
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

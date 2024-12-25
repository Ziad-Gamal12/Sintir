import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/Custom%20Course%20Widgets/CustomDisplayingVedioWidget.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CoursSectionsListItemEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseVedioItemEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CourseContentListView.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/DisplayCourseVedioView_Widgets/CustomSendNoteText.dart';
import 'package:sintir/constant.dart';

class DisplaycoursevedioveiwBody extends StatelessWidget {
  const DisplaycoursevedioveiwBody(
      {super.key, required this.vedio, required this.courseSectionsList});
  final Coursevedioitementity vedio;
  final List<CoursSectionsListItemEntity> courseSectionsList;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: KHorizontalPadding),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Customdisplayingvediowidget(
                    vedioUrl: vedio.vedioUrl,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  CustomSendNoteText(),
                  const SizedBox(
                    height: 25,
                  ),
                  const Divider(
                    height: 30,
                  ),
                  courseSectionsList.isEmpty
                      ? const Text("لا يوجد عناصر أخرى",
                          textAlign: TextAlign.center,
                          style: AppTextStyles.semiBold20)
                      : const Text("المحتوى",
                          textAlign: TextAlign.center,
                          style: AppTextStyles.bold24),
                  const SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
            CourseContentListView(courseSectionsEntity: courseSectionsList),
          ],
        ));
  }
}

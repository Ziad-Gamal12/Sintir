import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseVideoItemEntities/CourseVedioItemEntity.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/VideoConsequencesViewWidgets/VideoNotesSliverList.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/VideoConsequencesViewWidgets/VideoSummaryCard.dart';
import 'package:sintir/constant.dart';

class VideoConsequencesViewBody extends StatelessWidget {
  const VideoConsequencesViewBody({super.key, required this.video});
  final CourseVideoItemEntity video;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: KHorizontalPadding, vertical: KVerticalPadding),
        child: CustomScrollView(slivers: [
          SliverToBoxAdapter(child: VideoSummaryCard(video: video)),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 30,
            ),
          ),
          SliverToBoxAdapter(
            child: Text("ملاحظات الفيديو",
                textAlign: TextAlign.center,
                style: AppTextStyles(context).bold20),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 10,
            ),
          ),
          const VideoNotesSliverList()
        ]));
  }
}

import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseVideoItemEntities/CourseVedioItemEntity.dart';
import 'package:sintir/Core/widgets/CustomCard.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/VideoConsequencesViewWidgets/CustomVideoInfo.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/VideoConsequencesViewWidgets/VideoAttendancePresentage.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/VideoConsequencesViewWidgets/VideoStateInfo.dart';

class VideoSummaryCard extends StatelessWidget {
  const VideoSummaryCard({super.key, required this.video});
  final CourseVideoItemEntity video;

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CustomVideoInfo(video: video),
          const SizedBox(height: 20),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              VideoAttendancePresentage(),
              SizedBox(height: 20),
              VideoStateInfo(),
            ],
          )
        ],
      ),
    );
  }
}

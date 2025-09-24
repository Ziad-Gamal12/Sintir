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
          const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 3, child: VideoStateInfo()),
              SizedBox(width: 20),
              Expanded(flex: 1, child: VideoAttendancePresentage()),
            ],
          )
        ],
      ),
    );
  }
}

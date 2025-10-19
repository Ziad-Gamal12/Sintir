import 'package:flutter/material.dart';
import 'package:sintir/Core/widgets/CustomCard.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/VideoConsequencesViewRequirements.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/VideoConsequencesViewWidgets/CustomVideoInfo.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/VideoConsequencesViewWidgets/VideoStateInfo.dart';

class VideoSummaryCard extends StatelessWidget {
  const VideoSummaryCard({super.key, required this.requirements});
  final VideoConsequencesViewRequirements requirements;

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CustomVideoInfo(video: requirements.video),
          const SizedBox(height: 20),
          VideoStateInfo(
            requirements: requirements,
          )
        ],
      ),
    );
  }
}

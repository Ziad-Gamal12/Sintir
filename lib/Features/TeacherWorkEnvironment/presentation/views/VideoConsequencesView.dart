import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseVideoItemEntities/CourseVedioItemEntity.dart';
import 'package:sintir/Core/widgets/CustomAppBar.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/VideoConsequencesViewWidgets/VideoConsequencesViewBody.dart';

class VideoConsequencesView extends StatelessWidget {
  const VideoConsequencesView({super.key, required this.video});
  final CourseVideoItemEntity video;
  static String routeName = "/VideoConsequencesView";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(appBartitle: "التقارير الخاصة بالفيديو"),
      body: VideoConsequencesViewBody(video: video),
    );
  }
}

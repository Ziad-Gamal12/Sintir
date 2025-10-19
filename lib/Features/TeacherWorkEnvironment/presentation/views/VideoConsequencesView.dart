import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/repos/CourseSubscibtionsRepo/CourseSubscibtionsRepo.dart';
import 'package:sintir/Core/repos/Video-Item-Repo/VideoItemRepo.dart';
import 'package:sintir/Core/services/get_it_Service.dart';
import 'package:sintir/Core/widgets/CustomAppBar.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/VideoConsequencesViewRequirements.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/VideoConsequencesViewWidgets/VideoConsequencesViewBody.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/video_consequences_cubit/video_consequences_cubit.dart';

class VideoConsequencesView extends StatelessWidget {
  const VideoConsequencesView({super.key, required this.requirements});
  final VideoConsequencesViewRequirements requirements;
  static String routeName = "/VideoConsequencesView";
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VideoConsequencesCubit(
        subscibtionsRepo: getIt<CourseSubscibtionsRepo>(),
        videoItemRepo: getIt<VideoItemRepo>(),
      ),
      child: Scaffold(
        appBar: const CustomAppBar(appBartitle: "التقارير الخاصة بالفيديو"),
        body: VideoConsequencesViewBody(requirements: requirements),
      ),
    );
  }
}

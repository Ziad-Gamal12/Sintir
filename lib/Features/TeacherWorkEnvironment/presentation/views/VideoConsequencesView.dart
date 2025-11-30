import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/repos/CourseSubscibtionsRepo/CourseSubscibtionsRepo.dart';
import 'package:sintir/Core/repos/Video-Item-Repo/VideoItemRepo.dart';
import 'package:sintir/Core/services/get_it_Service.dart';
import 'package:sintir/Core/widgets/CustomAppBar.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/VideoConsequencesViewRequirements.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/VideoConsequencesViewWidgets/VideoConsequencesViewBody.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/get_video_notes_cubit/get_video_notes_cubit.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/video_consequences_cubit/video_consequences_cubit.dart';
import 'package:sintir/locale_keys.dart';

class VideoConsequencesView extends StatelessWidget {
  const VideoConsequencesView({super.key, required this.requirements});
  final VideoConsequencesViewRequirements requirements;
  static String routeName = "/VideoConsequencesView";
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => VideoConsequencesCubit(
            subscibtionsRepo: getIt<CourseSubscibtionsRepo>(),
            videoItemRepo: getIt<VideoItemRepo>(),
          ),
        ),
        BlocProvider(
          create: (context) => GetVideoNotesCubit(
            videoItemRepo: getIt<VideoItemRepo>(),
          ),
        ),
      ],
      child: Scaffold(
        appBar: CustomAppBar(appBartitle: LocaleKeys.videoReports),
        body: VideoConsequencesViewBody(requirements: requirements),
      ),
    );
  }
}

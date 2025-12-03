import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/VideoConsequencesViewRequirements.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/VideoConsequencesViewWidgets/VideoAttendancePresentage.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/VideoConsequencesViewWidgets/VideoStateInfoVideoAbsentWidget.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/VideoConsequencesViewWidgets/VideoStateInfoVideoAttendedWIdget.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/video_consequences_cubit/video_consequences_cubit.dart';

class VideoStateInfo extends StatefulWidget {
  const VideoStateInfo({super.key, required this.requirements});
  final VideoConsequencesViewRequirements requirements;
  @override
  State<VideoStateInfo> createState() => _VideoStateInfoState();
}

class _VideoStateInfoState extends State<VideoStateInfo> {
  int attendedCount = 0;
  int totalStudentsCount = 1;
  @override
  void initState() {
    super.initState();
    final cubit = context.read<VideoConsequencesCubit>();
    cubit.getTotalStudentsCount(courseId: widget.requirements.courseID);
    cubit.getVideoAttendedCount(
        courseId: widget.requirements.courseID,
        sectionId: widget.requirements.sectionID,
        videoId: widget.requirements.video.id);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<VideoConsequencesCubit, VideoConsequencesState>(
      listener: (context, state) {
        if (state is VideoConsequencesGetVideoAttendedCountSuccess) {
          setState(() {
            attendedCount = state.count;
          });
        } else if (state is VideoConsequencesGetTotalStudentsCountSuccess) {
          setState(() {
            totalStudentsCount = state.count;
          });
        }
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: VideoAttendancePresentage(
              percentage: attendedCount / totalStudentsCount * 100,
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const VideoStateInfoVideoAttendedWidget(),
                horizontalDivider(context),
                VideoStateInfoVideoAbsentWidget(
                  videoAbsentCount: totalStudentsCount - attendedCount,
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget verticalDivider(BuildContext context) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        height: 50,
        width: 1,
        color: Theme.of(context).dividerColor,
      );

  Widget horizontalDivider(BuildContext context) => Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        height: 1,
        color: Theme.of(context).dividerColor,
      );
}

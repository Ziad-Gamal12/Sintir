import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/video_consequences_cubit/video_consequences_cubit.dart';
import 'package:skeletonizer/skeletonizer.dart';

class VideoStateInfoVideoAbsentWidget extends StatefulWidget {
  const VideoStateInfoVideoAbsentWidget(
      {super.key, required this.videoAbsentCount});
  final int videoAbsentCount;
  @override
  State<VideoStateInfoVideoAbsentWidget> createState() =>
      _VideoStateInfoVideoAbsentWidgetState();
}

class _VideoStateInfoVideoAbsentWidgetState
    extends State<VideoStateInfoVideoAbsentWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VideoConsequencesCubit, VideoConsequencesState>(
      buildWhen: (previous, current) {
        return current is VideoConsequencesGetVideoAttendedCountSuccess ||
            current is VideoConsequencesGetVideoAttendedCountLoading ||
            current is VideoConsequencesGetVideoAttendedCountFailure ||
            current is VideoConsequencesGetTotalStudentsCountSuccess ||
            current is VideoConsequencesGetTotalStudentsCountLoading ||
            current is VideoConsequencesGetTotalStudentsCountFailure;
      },
      builder: (context, state) {
        return Skeletonizer(
          enabled: state is VideoConsequencesGetVideoAttendedCountLoading ||
              state is VideoConsequencesGetTotalStudentsCountLoading,
          child: _buildStatColumn("عدد الطلاب الغائبين:",
              getVideoAbsentCount(state: state), context,
              color: Colors.red),
        );
      },
    );
  }

  String getVideoAbsentCount({
    required VideoConsequencesState state,
  }) {
    if (state is VideoConsequencesGetVideoAttendedCountFailure) {
      return state.errMessage;
    } else if (state is VideoConsequencesGetTotalStudentsCountFailure) {
      return state.errMessage;
    } else {
      return widget.videoAbsentCount.toString();
    }
  }

  Widget _buildStatColumn(String label, String value, BuildContext context,
      {Color color = Colors.black}) {
    return Column(
      children: [
        Text(label,
            style: AppTextStyles(context)
                .semiBold14
                .copyWith(color: Colors.black)),
        const SizedBox(height: 10),
        Text(value,
            style: AppTextStyles(context).bold14.copyWith(color: color)),
      ],
    );
  }
}

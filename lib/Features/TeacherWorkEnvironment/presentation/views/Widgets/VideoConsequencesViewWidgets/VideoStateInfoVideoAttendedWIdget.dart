import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/video_consequences_cubit/video_consequences_cubit.dart';
import 'package:sintir/locale_keys.dart';
import 'package:skeletonizer/skeletonizer.dart';

class VideoStateInfoVideoAttendedWidget extends StatefulWidget {
  const VideoStateInfoVideoAttendedWidget({super.key});

  @override
  State<VideoStateInfoVideoAttendedWidget> createState() =>
      _VideoStateInfoVideoAttendedWidgetState();
}

class _VideoStateInfoVideoAttendedWidgetState
    extends State<VideoStateInfoVideoAttendedWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VideoConsequencesCubit, VideoConsequencesState>(
      buildWhen: (previous, current) =>
          current is VideoConsequencesGetVideoAttendedCountSuccess ||
          current is VideoConsequencesGetVideoAttendedCountLoading ||
          current is VideoConsequencesGetVideoAttendedCountFailure,
      builder: (context, state) {
        return Skeletonizer(
          enabled: state is VideoConsequencesGetVideoAttendedCountLoading,
          child: _buildStatColumn(LocaleKeys.studentsAttended,
              getVideoAttendedCount(state: state), context,
              color: Colors.green),
        );
      },
    );
  }

  String getVideoAttendedCount({
    required VideoConsequencesState state,
  }) {
    if (state is VideoConsequencesGetVideoAttendedCountSuccess) {
      return state.count.toString();
    } else if (state is VideoConsequencesGetVideoAttendedCountFailure) {
      return state.errMessage;
    } else {
      return "0";
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

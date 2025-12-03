import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/video_consequences_cubit/video_consequences_cubit.dart';
import 'package:sintir/locale_keys.dart';
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
    final ThemeData theme = Theme.of(context);
    final Color errorColor = theme.colorScheme.error;

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
          child: _buildStatColumn(LocaleKeys.studentsAbsent,
              getVideoAbsentCount(state: state, context: context), context,
              color: errorColor),
        );
      },
    );
  }

  String getVideoAbsentCount({
    required VideoConsequencesState state,
    required BuildContext context,
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
    final ThemeData theme = Theme.of(context);
    final Color labelColor = theme.textTheme.bodyLarge!.color!;
    final Color errorColor = theme.colorScheme.error;

    // Check if the value is an error message from the state
    final String? failureMessage1 = (context
            .read<VideoConsequencesCubit>()
            .state is VideoConsequencesGetVideoAttendedCountFailure)
        ? (context.read<VideoConsequencesCubit>().state
                as VideoConsequencesGetVideoAttendedCountFailure)
            .errMessage
        : null;
    final String? failureMessage2 = (context
            .read<VideoConsequencesCubit>()
            .state is VideoConsequencesGetTotalStudentsCountFailure)
        ? (context.read<VideoConsequencesCubit>().state
                as VideoConsequencesGetTotalStudentsCountFailure)
            .errMessage
        : null;

    final bool isError = value == failureMessage1 || value == failureMessage2;

    final Color valueColor = isError ? errorColor : color;

    return Column(
      children: [
        Text(label,
            style:
                AppTextStyles(context).semiBold14.copyWith(color: labelColor)),
        const SizedBox(height: 10),
        Text(value,
            style: AppTextStyles(context).bold14.copyWith(color: valueColor)),
      ],
    );
  }
}

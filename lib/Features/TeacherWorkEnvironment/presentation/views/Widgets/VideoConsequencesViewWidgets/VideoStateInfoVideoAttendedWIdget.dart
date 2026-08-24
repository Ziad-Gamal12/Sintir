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
    const Color successColor = Colors.green;

    return BlocBuilder<VideoConsequencesCubit, VideoConsequencesState>(
      buildWhen: (previous, current) =>
          current is VideoConsequencesGetVideoAttendedCountSuccess ||
          current is VideoConsequencesGetVideoAttendedCountLoading ||
          current is VideoConsequencesGetVideoAttendedCountFailure,
      builder: (context, state) {
        return Skeletonizer(
          enabled: state is VideoConsequencesGetVideoAttendedCountLoading,
          child: _buildStatColumn(LocaleKeys.studentsAttended,
              getVideoAttendedCount(state: state, context: context), context,
              color: successColor),
        );
      },
    );
  }

  String getVideoAttendedCount({
    required VideoConsequencesState state,
    required BuildContext context,
  }) {
    if (state is VideoConsequencesGetVideoAttendedCountSuccess) {
      return state.count.clamp(0, double.infinity).toString();
    } else if (state is VideoConsequencesGetVideoAttendedCountFailure) {
      return state.errMessage;
    } else {
      return "0";
    }
  }

  Widget _buildStatColumn(String label, String value, BuildContext context,
      {Color color = Colors.black}) {
    final ThemeData theme = Theme.of(context);
    final Color labelColor = theme.textTheme.bodyLarge!.color!;
    final Color errorColor = theme.colorScheme.error;

    final bool isError = (context.read<VideoConsequencesCubit>().state
        is VideoConsequencesGetVideoAttendedCountFailure);

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

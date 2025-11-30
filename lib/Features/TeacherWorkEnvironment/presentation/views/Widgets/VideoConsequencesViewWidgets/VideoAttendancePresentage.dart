import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/video_consequences_cubit/video_consequences_cubit.dart';
import 'package:sintir/constant.dart';
import 'package:sintir/locale_keys.dart';
import 'package:skeletonizer/skeletonizer.dart';

class VideoAttendancePresentage extends StatefulWidget {
  const VideoAttendancePresentage({super.key, required this.percentage});
  final double percentage;

  @override
  State<VideoAttendancePresentage> createState() =>
      _VideoAttendancePresentageState();
}

class _VideoAttendancePresentageState extends State<VideoAttendancePresentage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<VideoConsequencesCubit, VideoConsequencesState>(
          buildWhen: (previous, current) =>
              current is VideoConsequencesGetVideoAttendedCountSuccess ||
              current is VideoConsequencesGetVideoAttendedCountLoading ||
              current is VideoConsequencesGetVideoAttendedCountFailure ||
              current is VideoConsequencesGetTotalStudentsCountSuccess ||
              current is VideoConsequencesGetTotalStudentsCountLoading ||
              current is VideoConsequencesGetTotalStudentsCountFailure,
          builder: (context, state) {
            if (state is VideoConsequencesGetVideoAttendedCountFailure) {
              return Text(state.errMessage,
                  style: AppTextStyles(context)
                      .regular14
                      .copyWith(color: Colors.red));
            } else if (state is VideoConsequencesGetTotalStudentsCountFailure) {
              return Text(state.errMessage,
                  style: AppTextStyles(context)
                      .regular14
                      .copyWith(color: Colors.red));
            }
            return Skeletonizer(
              enabled: state is VideoConsequencesGetVideoAttendedCountLoading ||
                  state is VideoConsequencesGetTotalStudentsCountLoading,
              child: CircularPercentIndicator(
                radius: 45,
                lineWidth: 10.0,
                animation: true,
                percent: widget.percentage / 100,
                center: Text(
                  "${widget.percentage.toStringAsFixed(2)} %",
                  style: AppTextStyles(context)
                      .semiBold16
                      .copyWith(color: Colors.black),
                ),
                progressColor: KMainColor,
                circularStrokeCap: CircularStrokeCap.round,
              ),
            );
          },
        ),
        const SizedBox(
          height: 10,
        ),
        Text(LocaleKeys.attendanceRate,
            textAlign: TextAlign.center,
            style: AppTextStyles(context).semiBold16)
      ],
    );
  }
}

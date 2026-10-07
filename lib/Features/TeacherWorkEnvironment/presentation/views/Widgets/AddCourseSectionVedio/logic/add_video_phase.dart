import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/CourseSectionsCubit/CourseSectionsCubit.dart';
import 'package:sintir/Core/Managers/Cubits/video_item_cubit/video_item_cubit.dart';

/// What the screen is doing right now, derived from the two cubits that take
/// part in "upload video, then add it to the section".
enum AddVideoPhase {
  idle,
  uploading,
  saving,
  failed;

  bool get isBusy => this == uploading || this == saving;

  static AddVideoPhase fromVideoState(VideoItemState state) => switch (state) {
        UploadVideoLoading() => uploading,
        UploadVideoSuccess() || AddVideoItemLoading() => saving,
        UploadVideoFailure() => failed,
        _ => idle,
      };

  /// One-off read for callbacks (not for build methods).
  static AddVideoPhase read(BuildContext context) {
    final sectionState = context.read<CourseSectionsCubit>().state;
    if (sectionState is AddCourseSectionItemLoading) return saving;
    return fromVideoState(context.read<VideoItemCubit>().state);
  }
}

/// Rebuilds only when the phase changes, not on every upload progress tick.
class AddVideoPhaseBuilder extends StatelessWidget {
  const AddVideoPhaseBuilder({super.key, required this.builder});

  final Widget Function(BuildContext context, AddVideoPhase phase) builder;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<CourseSectionsCubit, CourseSectionsState, bool>(
      selector: (state) => state is AddCourseSectionItemLoading,
      builder: (context, isSavingSection) =>
          BlocSelector<VideoItemCubit, VideoItemState, AddVideoPhase>(
        selector: AddVideoPhase.fromVideoState,
        builder: (context, videoPhase) => builder(
          context,
          isSavingSection ? AddVideoPhase.saving : videoPhase,
        ),
      ),
    );
  }
}

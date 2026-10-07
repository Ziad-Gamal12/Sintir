import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/video_item_cubit/video_item_cubit.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddCourseSectionVedio/widgets/picker/upload_progress_card.dart';

class UploadProgressSection extends StatelessWidget {
  const UploadProgressSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<VideoItemCubit, VideoItemState, UploadVideoLoading?>(
      selector: (state) => state is UploadVideoLoading ? state : null,
      builder: (context, upload) {
        if (upload == null) return const SizedBox.shrink();
        return UploadProgressCard(
          progress: upload.progress,
          uploadedBytes: upload.uploadedBytes,
          totalBytes: upload.totalBytes,
          etaSeconds: upload.etaSeconds,
          onCancel: () => context.read<VideoItemCubit>().cancelVideoUpload(),
        );
      },
    );
  }
}

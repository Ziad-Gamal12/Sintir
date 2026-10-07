import 'package:flutter/material.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddCourseSectionVedio/controllers/video_preview_controller.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddCourseSectionVedio/widgets/picker/selected_video_actions.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddCourseSectionVedio/widgets/picker/selected_video_details.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddCourseSectionVedio/widgets/picker/video_thumbnail_preview.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddCourseSectionVedio/widgets/shared/surface_card.dart';

class SelectedVideoCard extends StatelessWidget {
  const SelectedVideoCard({
    super.key,
    required this.preview,
    required this.enabled,
    required this.onChange,
    required this.onRemove,
  });

  final VideoPreviewController preview;
  final bool enabled;
  final VoidCallback onChange;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return SurfaceCard(
      hasBorder: false,
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          VideoThumbnailPreview(preview: preview),
          const SizedBox(height: 12),
          SelectedVideoDetails(preview: preview),
          const SizedBox(height: 8),
          SelectedVideoActions(
            enabled: enabled,
            onChange: onChange,
            onRemove: onRemove,
          ),
        ],
      ),
    );
  }
}

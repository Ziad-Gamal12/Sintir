import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/video_item_cubit/video_item_cubit.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseVideoItemEntities/CourseVideoviewnavigationsrequirmentsentity.dart';
import 'package:sintir/Core/widgets/CustomButton.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/VideoNoteEntity.dart';
import 'package:sintir/constant.dart';

class CustomSendNoteWidgetBodyActionButton extends StatelessWidget {
  const CustomSendNoteWidgetBodyActionButton({
    super.key,
    required this.formKey,
    required this.coursevideoviewnavigationsrequirmentsentity,
  });
  final GlobalKey<FormState> formKey;
  final Coursevideoviewnavigationsrequirmentsentity
      coursevideoviewnavigationsrequirmentsentity;

  @override
  Widget build(BuildContext context) {
    VideoNoteEntity note = context.read<VideoNoteEntity>();
    return BlocBuilder<VideoItemCubit, VideoItemState>(
      builder: (context, state) {
        if (state is AddVideoNoteLoading) {
          return const Center(
              child: CircularProgressIndicator(
            color: KSecondaryColor,
          ));
        }
        return Custombutton(
            text: "ارسال",
            color: KSecondaryColor,
            textColor: Colors.white,
            onPressed: () {
              if (formKey.currentState!.validate()) {
                formKey.currentState!.save();
                context.read<VideoItemCubit>().addVideoNote(
                    coursId: coursevideoviewnavigationsrequirmentsentity
                        .courseEntity.id,
                    sectionId:
                        coursevideoviewnavigationsrequirmentsentity.sectionId,
                    videoId:
                        coursevideoviewnavigationsrequirmentsentity.video.id,
                    note: note);
              }
            });
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/CourseSectionsCubit/CourseSectionsCubit.dart';
import 'package:sintir/Core/Managers/Cubits/video_item_cubit/video_item_cubit.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseVideoItemEntities/CourseVedioItemEntity.dart';
import 'package:sintir/Core/utils/Variables.dart';
import 'package:sintir/Core/widgets/CustomButton.dart';
import 'package:sintir/Core/widgets/Custom_Loading_Widget.dart';
import 'package:sintir/constant.dart';
import 'package:sintir/locale_keys.dart';

class CustomAddCourseVideoSectionButton extends StatelessWidget {
  const CustomAddCourseVideoSectionButton({
    super.key,
    required this.coursevedioitementity,
  });

  final CourseVideoItemEntity coursevedioitementity;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VideoItemCubit, VideoItemState>(
      builder: (context, state) {
        final isLoading =
            state is UploadVideoLoading || state is AddCourseSectionItemLoading;

        return Custom_Loading_Widget(
          isLoading: isLoading,
          child: Custombutton(
            text: coursevedioitementity.file == null
                ? LocaleKeys.selectVideo
                : LocaleKeys.addVideoButton,
            color: coursevedioitementity.file == null
                ? KSecondaryColor
                : Colors.green,
            textColor: Colors.white,
            onPressed: () {
              if (coursevedioitementity.file == null) {
                context.read<VideoItemCubit>().pickVideoFile(
                    coursevedioitementity: coursevedioitementity);
              } else {
                if (Variables.AddCourseSectionVideoItemFormKey.currentState!
                    .validate()) {
                  context.read<VideoItemCubit>().uploadVideo(
                      coursevedioitementity: coursevedioitementity);
                }
              }
            },
          ),
        );
      },
    );
  }
}

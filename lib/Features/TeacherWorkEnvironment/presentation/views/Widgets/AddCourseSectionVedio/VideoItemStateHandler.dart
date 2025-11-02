import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/Managers/Cubits/CourseSectionsCubit/CourseSectionsCubit.dart';
import 'package:sintir/Core/Managers/Cubits/video_item_cubit/video_item_cubit.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseVideoItemEntities/CourseVedioItemEntity.dart';
import 'package:sintir/Core/helper/ShowSnackBar.dart';
import 'package:sintir/Core/utils/Variables.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/AwesomeDialog.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/OptionNavigationRequirementsEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSections_SectionWidgets/CourseDetailsCourseSectionsView.dart';

class VideoItemStateHandler {
  final BuildContext context;
  final CourseVideoItemEntity videoEntity;

  VideoItemStateHandler(this.context, this.videoEntity);

  void handle(VideoItemState state) {
    switch (state) {
      case AddVideoItemFailure(:final errMessage):
        errordialog(context, errMessage).show();
        break;

      case AddVideoItemSuccess():
        successdialog(
          context: context,
          SuccessMessage: "تم اضافة الملف بنجاح",
          btnOkOnPress: () => context.go(
            CourseDetailsCourseSectionsView.routeName,
            extra:
                context.read<OptionNavigationRequirementsEntity>().courseEntity,
          ),
        ).show();
        break;

      case PickVideoFileSuccess(:final file):
        videoEntity.file = file;
        break;

      case PickVideoFileFailure():
        ShowSnackBar(
          context: context,
          child: Text("لم يتم اختيار الملف",
              style: AppTextStyles(context)
                  .regular14
                  .copyWith(color: Colors.white)),
          backgroundColor: Colors.red,
        );
        break;

      case UploadVideoSuccess(:final url):
        _onUploadSuccess(url);
        break;

      case UploadVideoFailure(:final errMessage):
        ShowSnackBar(
          context: context,
          child: Text(errMessage,
              style: AppTextStyles(context)
                  .regular14
                  .copyWith(color: Colors.white)),
          backgroundColor: Colors.red,
        );
        break;

      default:
        break;
    }
  }

  void _onUploadSuccess(String url) {
    Variables.AddCourseSectionVideoItemFormKey.currentState?.save();

    final option = context.read<OptionNavigationRequirementsEntity>();
    videoEntity.vedioUrl = url;

    if (option.isNewSection) {
      context.read<CourseSectionsCubit>().addCourseSection(
            sectionItem: videoEntity,
            courseId: option.courseEntity.id,
            section: option.section,
          );
    } else {
      context.read<VideoItemCubit>().addVideoItem(
            courseId: option.courseEntity.id,
            sectionId: option.section.id,
            video: videoEntity,
          );
    }
  }
}

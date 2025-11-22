import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/video_item_cubit/video_item_cubit.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseVideoItemEntities/CourseVideoviewnavigationsrequirmentsentity.dart';
import 'package:sintir/Core/helper/ShowSnackBar.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/DisplayCourseVedioView_Widgets/CustomSendNoteWidgetBodyActionButton.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/DisplayCourseVedioView_Widgets/CustomSendNoteWidgetBodyHeader.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/DisplayCourseVedioView_Widgets/CustomSendNoteWidgetBodyTextField.dart';
import 'package:sintir/constant.dart';

class CustomSendNoteWidgetBody extends StatefulWidget {
  const CustomSendNoteWidgetBody({
    super.key,
    required this.coursevideoviewnavigationsrequirmentsentity,
  });

  final CourseVideoViewNavigationsRequirmentsEntity
      coursevideoviewnavigationsrequirmentsentity;

  @override
  State<CustomSendNoteWidgetBody> createState() =>
      _CustomSendNoteWidgetBodyState();
}

class _CustomSendNoteWidgetBodyState extends State<CustomSendNoteWidgetBody> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocListener<VideoItemCubit, VideoItemState>(
      listener: (context, state) {
        if (state is AddVideoNoteSuccess) {
          CustomSnackBar.show(
            context,
            message: "تم اضافة الملاحظة بنجاح",
            type: SnackType.success,
          );
          Navigator.pop(context);
        } else if (state is AddVideoNoteFailure) {
          CustomSnackBar.show(
            context,
            message: state.errMessage,
            type: SnackType.error,
          );
        }
      },
      child: Form(
        key: formKey,
        child: Container(
          padding: const EdgeInsets.symmetric(
              horizontal: KHorizontalPadding, vertical: 20),
          height: MediaQuery.sizeOf(context).height * .35,
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              border: Border.all(color: Colors.grey, width: 1)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomSendNoteWidgetBodyHeader(),
              const SizedBox(
                height: 16,
              ),
              const CustomSendNoteWidgetBodyTextField(),
              const Spacer(),
              CustomSendNoteWidgetBodyActionButton(
                formKey: formKey,
                coursevideoviewnavigationsrequirmentsentity:
                    widget.coursevideoviewnavigationsrequirmentsentity,
              )
            ],
          ),
        ),
      ),
    );
  }
}

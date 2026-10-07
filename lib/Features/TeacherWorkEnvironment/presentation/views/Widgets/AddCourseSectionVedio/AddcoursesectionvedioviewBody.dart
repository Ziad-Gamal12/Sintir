import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/CourseSectionsCubit/CourseSectionsCubit.dart';
import 'package:sintir/Core/Managers/Cubits/video_item_cubit/video_item_cubit.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/OptionNavigationRequirementsEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddCourseSectionViewWidgets/CourseSectionStateHandler.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddCourseSectionVedio/controllers/add_video_form_controller.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddCourseSectionVedio/logic/leave_add_video_screen.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddCourseSectionVedio/logic/video_item_state_handler.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddCourseSectionVedio/utils/add_video_dimens.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddCourseSectionVedio/widgets/form/add_video_bottom_bar.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddCourseSectionVedio/widgets/form/add_video_form_content.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddCourseSectionVedio/widgets/form/add_video_leave_guard.dart';

class Addcoursesectionvedioviewbody extends StatefulWidget {
  const Addcoursesectionvedioviewbody({super.key});

  @override
  State<Addcoursesectionvedioviewbody> createState() =>
      _AddcoursesectionvedioviewbodyState();
}

class _AddcoursesectionvedioviewbodyState
    extends State<Addcoursesectionvedioviewbody> {
  final _form = AddVideoFormController();

  @override
  void dispose() {
    _form.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_form.validate()) return;
    final option = context.read<OptionNavigationRequirementsEntity>();
    context.read<VideoItemCubit>().uploadVideo(
          coursevedioitementity: _form.prepareForUpload(),
          courseId: option.courseEntity.id,
          sectionId: option.section.id,
        );
  }

  @override
  Widget build(BuildContext context) {
    final option = context.read<OptionNavigationRequirementsEntity>();

    return BlocListener<CourseSectionsCubit, CourseSectionsState>(
      listener: (context, state) =>
          CourseSectionStateHandler(context, option.courseEntity).handle(state),
      child: BlocListener<VideoItemCubit, VideoItemState>(
        listener: (context, state) =>
            VideoItemStateHandler(context, _form).handle(state),
        child: AddVideoLeaveGuard(
          form: _form,
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: AddVideoDimens.maxContentWidth,
              ),
              child: Column(
                children: [
                  Expanded(
                    child: AddVideoFormContent(form: _form, option: option),
                  ),
                  AddVideoBottomBar(
                    form: _form,
                    onSubmit: _submit,
                    onDiscard: () => leaveAddVideoScreen(context, _form),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/OptionNavigationRequirementsEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddCourseSectionVedio/controllers/add_video_form_controller.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddCourseSectionVedio/logic/add_video_phase.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddCourseSectionVedio/utils/add_video_dimens.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddCourseSectionVedio/widgets/form/lesson_context_card.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddCourseSectionVedio/widgets/form/platform_standards_card.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddCourseSectionVedio/widgets/form/video_file_label_row.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddCourseSectionVedio/widgets/form/video_title_input_field.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddCourseSectionVedio/widgets/picker/video_picker_section.dart';

class AddVideoFormContent extends StatelessWidget {
  const AddVideoFormContent({
    super.key,
    required this.form,
    required this.option,
  });

  final AddVideoFormController form;
  final OptionNavigationRequirementsEntity option;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => FocusScope.of(context).unfocus(),
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        padding: AddVideoDimens.screenPadding,
        child: Form(
          key: form.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              LessonContextCard(option: option),
              const SizedBox(height: 20),
              AddVideoPhaseBuilder(
                builder: (context, phase) => VideoTitleInputField(
                  controller: form.titleController,
                  enabled: !phase.isBusy,
                ),
              ),
              const SizedBox(height: 18),
              const VideoFileLabelRow(),
              const SizedBox(height: 10),
              VideoPickerSection(form: form),
              const SizedBox(height: 20),
              const PlatformStandardsCard(),
            ],
          ),
        ),
      ),
    );
  }
}

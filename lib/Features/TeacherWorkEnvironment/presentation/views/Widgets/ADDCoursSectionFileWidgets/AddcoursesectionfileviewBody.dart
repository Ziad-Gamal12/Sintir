import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:sintir/Core/Managers/Cubits/CourseSectionsCubit/CourseSectionsCubit.dart';
import 'package:sintir/Core/Managers/Cubits/file_item_cubit/file_item_cubit.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseFileEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/OptionNavigationRequirementsEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/ADDCoursSectionFileWidgets/AddCourseSectionFileTextFields.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/ADDCoursSectionFileWidgets/CustomAddCourseSectionFileActionButton.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/ADDCoursSectionFileWidgets/FileItemStateHandler.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddcoursesectionviewWidgets/CourseSectionStateHandler.dart';
import 'package:sintir/constant.dart';

class AddcoursesectionfileviewBody extends StatefulWidget {
  const AddcoursesectionfileviewBody({super.key});

  @override
  State<AddcoursesectionfileviewBody> createState() =>
      _AddcoursesectionfileviewBodyState();
}

class _AddcoursesectionfileviewBodyState
    extends State<AddcoursesectionfileviewBody> {
  late final CourseFileEntity courseFileEntity;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    courseFileEntity = CourseFileEntity(
      title: "",
      description: "",
      fileUrl: "",
      id: "${DateTime.now().toIso8601String()}-File",
    );
  }

  @override
  Widget build(BuildContext context) {
    OptionNavigationRequirementsEntity optionnavigationrequirementsentity =
        Provider.of<OptionNavigationRequirementsEntity>(context);
    return MultiBlocListener(
      listeners: [
        BlocListener<FileItemCubit, FileItemState>(
          listener: (context, state) => FileItemStateHandler(
            context,
            courseFileEntity,
            optionnavigationrequirementsentity.courseEntity,
            formKey,
          ).handle(state),
        ),
        BlocListener<CourseSectionsCubit, CourseSectionsState>(
          listener: (context, state) => CourseSectionStateHandler(
                  context, optionnavigationrequirementsentity.courseEntity)
              .handle(state),
        ),
      ],
      child: BlocBuilder<FileItemCubit, FileItemState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: KHorizontalPadding),
            child: Form(
              key: formKey,
              child: Stack(
                children: [
                  AddCourseSectionFileTextFields(
                    coursefilEentity: courseFileEntity,
                  ),
                  Positioned(
                    bottom: 20,
                    left: 16,
                    right: 16,
                    child: CustomAddCourseSectionFileActionButton(
                      fileentity: courseFileEntity,
                      formKey: formKey,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

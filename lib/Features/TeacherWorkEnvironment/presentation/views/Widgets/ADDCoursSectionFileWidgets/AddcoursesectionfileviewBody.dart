import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sintir/Core/Managers/Cubits/CourseSectionsCubit/CourseSectionsCubit.dart';
import 'package:sintir/Core/Managers/Cubits/file_item_cubit/file_item_cubit.dart';
import 'package:sintir/Core/helper/ShowSnackBar.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/AwesomeDialog.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseFileEntity.dart';
import 'package:sintir/Features/Home/presentation/views/HomeView.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/OptionNavigationRequirementsEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/ADDCoursSectionFileWidgets/AddCourseSectionFileTextFields.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/ADDCoursSectionFileWidgets/CustomAddCourseSectionFileActionButton.dart';
import 'package:sintir/constant.dart';

class AddcoursesectionfileviewBody extends StatefulWidget {
  const AddcoursesectionfileviewBody({
    super.key,
  });
  @override
  State<AddcoursesectionfileviewBody> createState() =>
      _AddcoursesectionfileviewBodyState();
}

class _AddcoursesectionfileviewBodyState
    extends State<AddcoursesectionfileviewBody> {
  CourseFileEntity coursefilEentity = CourseFileEntity(
      title: "",
      description: "",
      fileUrl: "",
      id: "${DateTime.now().toIso8601String()}-File");

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<FileItemCubit, FileItemState>(listener: (context, state) {
          fileItemListener(state, context);
        }),
        BlocListener<CourseSectionsCubit, CourseSectionsState>(
            listener: (context, state) {
          courseSectionListener(state, context);
        })
      ],
      child: BlocBuilder<FileItemCubit, FileItemState>(
        builder: (context, state) {
          return Provider.value(
            value: coursefilEentity,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: KHorizontalPadding),
              child: Form(
                key: formKey,
                child: Stack(
                  children: [
                    AddCourseSectionFileTextFields(
                      coursefilEentity: coursefilEentity,
                    ),
                    Positioned(
                        bottom: 20,
                        left: 16,
                        right: 16,
                        child: CustomAddCourseSectionFileActionButton(
                          fileentity: coursefilEentity,
                          formKey: formKey,
                        )),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void courseSectionListener(CourseSectionsState state, BuildContext context) {
    if (state is AddCourseSectionFailure) {
      errordialog(context, state.errMessage).show();
    } else if (state is AddCourseSectionSuccess) {
      successdialog(
          context: context,
          SuccessMessage: "تم اضافة الملف بنجاح",
          btnOkOnPress: () {
            context.go(
              Homeview.routeName,
            );
          }).show();
    }
  }

  void fileItemListener(FileItemState state, BuildContext context) {
    if (state is AddFileItemFailure) {
      errordialog(context, state.errMessage).show();
    } else if (state is AddFileItemSuccess) {
      successdialog(
          context: context,
          SuccessMessage: "تم اضافة الملف بنجاح",
          btnOkOnPress: () {
            context.go(
              Homeview.routeName,
            );
          }).show();
    } else if (state is PickFileSuccess) {
      coursefilEentity.file = state.file;
    } else if (state is PickFileFailure) {
      ShowSnackBar(
          context: context,
          child: Text("لم يتم اختيار الملف",
              style: AppTextStyles.regular14.copyWith(color: Colors.white)),
          backgroundColor: Colors.red);
    } else if (state is UplaodFileSuccess) {
      fileUploadedSuccessState(context, state);
    } else if (state is UplaodFileFailure) {
      ShowSnackBar(
          context: context,
          child: Text(state.errMessage,
              style: AppTextStyles.regular14.copyWith(color: Colors.white)),
          backgroundColor: Colors.red);
    }
  }

  void fileUploadedSuccessState(BuildContext context, UplaodFileSuccess state) {
    formKey.currentState!.save();
    Optionnavigationrequirementsentity optionnavigationrequirementsentity =
        context.read<Optionnavigationrequirementsentity>();
    coursefilEentity.fileUrl = state.url;
    if (optionnavigationrequirementsentity.isNewSection) {
      context.read<CourseSectionsCubit>().addCourseSection(
          sectionItem: coursefilEentity,
          courseId: optionnavigationrequirementsentity.courseID,
          section: optionnavigationrequirementsentity.section);
    } else {
      context.read<CourseSectionsCubit>().addSectionItem(
          courseId: optionnavigationrequirementsentity.courseID,
          sectionId: optionnavigationrequirementsentity.section.id,
          sectionItem: coursefilEentity);
    }
  }
}

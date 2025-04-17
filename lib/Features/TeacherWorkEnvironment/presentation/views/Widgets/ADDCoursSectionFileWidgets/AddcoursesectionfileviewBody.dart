import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sintir/Core/Managers/Cubits/CourseSectionsCubit/CourseSectionsCubit.dart';
import 'package:sintir/Core/widgets/AwesomeDialog.dart';
import 'package:sintir/Core/widgets/Custom_Loading_Widget.dart';
import 'package:sintir/Core/widgets/showSnackBar.dart';
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
  Coursefileentity coursefilEentity = Coursefileentity(
      title: "",
      description: "",
      fileUrl: "",
      id: "${DateTime.now().toIso8601String()}-File");

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CourseSectionsCubit, CourseSectionsState>(
      listener: (context, state) {
        addCourseSectionFileItemBLocListener(state, context);
      },
      builder: (context, state) {
        return Provider.value(
          value: coursefilEentity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: KHorizontalPadding),
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
                      child: Custom_Loading_Widget(
                          isLoading: state is UpdateCourseSectionsLoading ||
                              state is FileUploadedingLoading,
                          child: CustomAddCourseSectionFileActionButton(
                            fileentity: coursefilEentity,
                            formKey: formKey,
                          ))),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void addCourseSectionFileItemBLocListener(
      CourseSectionsState state, BuildContext context) {
    if (state is AddCourseSectionFilePicked) {
      coursefilEentity.file = state.file;
    } else if (state is AddCourseSectionFileUnPicked) {
      showSnackBar(context, "حدث خطأ اثناء اختيار الملف");
    } else if (state is FileUploadedingSuccuss) {
      fileUploadedSuccessState(context, state);
    } else if (state is FileUploadedingFailure) {
      showSnackBar(context, state.errMessage);
    } else if (state is AddCourseSectionSuccess) {
      successdialog(
          context: context,
          SuccessMessage: "تم اضافة الملف بنجاح",
          btnOkOnPress: () {
            context.go(
              Homeview.routeName,
            );
          }).show();
    } else if (state is AddCourseSectionFailure) {
      errordialog(context, state.errMessage).show();
    }
  }

  void fileUploadedSuccessState(
      BuildContext context, FileUploadedingSuccuss state) {
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

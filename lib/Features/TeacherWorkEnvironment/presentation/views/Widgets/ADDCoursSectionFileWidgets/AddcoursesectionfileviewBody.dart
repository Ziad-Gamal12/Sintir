import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pdfx/pdfx.dart';
import 'package:provider/provider.dart';
import 'package:sintir/Core/widgets/AwesomeDialog.dart';
import 'package:sintir/Core/widgets/Custom_Loading_Widget.dart';
import 'package:sintir/Core/widgets/showSnackBar.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseFileEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/ADDCoursSectionFileWidgets/AddCourseSectionFileTextFields.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/ADDCoursSectionFileWidgets/CustomAddCourseSectionFileActionButton.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/AddCourseSectionCubit/AddCourseSectionCubit.dart';
import 'package:sintir/constant.dart';

class AddcoursesectionfileviewBody extends StatefulWidget {
  const AddcoursesectionfileviewBody({super.key});

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
  );
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  PdfControllerPinch? pdfControllerPinch;
  int totalPages = 0;
  int currentPage = 1;

  @override
  void initState() {
    coursefilEentity.file?.watch().listen((event) {
      if (event.path.isNotEmpty || event.path != "") {
        pdfControllerPinch = PdfControllerPinch(
            document: PdfDocument.openFile(coursefilEentity.file!.path));
        setState(() {});
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddCourseSectionCubit, AddCourseSectionState>(
      listener: (context, state) {
        if (state is AddCourseSectionFilePicked) {
          coursefilEentity.file = state.file;
          log(coursefilEentity.file!.path);
        } else if (state is AddCourseSectionFileUnPicked) {
          showSnackBar(context, "حدث خطأ اثناء اختيار الملف");
        } else if (state is AddCourseSectionAddSectionSuccess) {
          successdialog(
                  context: context,
                  SuccessMessage: "تم اضافة الملف بنجاح",
                  btnOkOnPress: () {})
              .show();
        } else if (state is AddCourseSectionAddSectionFailure) {
          errordialog(context, state.errMessage).show();
        }
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
                  const AddCourseSectionFileTextFields(),
                  Positioned(
                      bottom: 20,
                      left: 16,
                      right: 16,
                      child: Custom_Loading_Widget(
                          isLoading: state is AddCourseSectionAddSectionLoading,
                          child: CustomAddCourseSectionFileActionButton(
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
}

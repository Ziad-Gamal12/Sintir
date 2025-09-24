import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:pdfx/pdfx.dart';
import 'package:sintir/Core/Managers/Cubits/file_item_cubit/file_item_cubit.dart';
import 'package:sintir/Core/helper/GetUserData.dart';
import 'package:sintir/Core/helper/ShowSnackBar.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseFileEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseFileviewnavigationsrequirmentsentity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/JoinedByEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CourseFIlePreViewer_Widgets/CourseFileOverView.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/addingJoinedByLoadingWidget.dart';
import 'package:skeletonizer/skeletonizer.dart';

class Coursefilepreviewerviewbody extends StatefulWidget {
  const Coursefilepreviewerviewbody({super.key, required this.file});
  final CourseFileEntity file;

  @override
  State<Coursefilepreviewerviewbody> createState() =>
      _CoursefilepreviewerviewbodyState();
}

class _CoursefilepreviewerviewbodyState
    extends State<Coursefilepreviewerviewbody> {
  PdfControllerPinch? pdfControllerPinch;
  int totalPages = 0;
  int currentPage = 1;
  bool isLoading = true;

  Future<void> loadPdf() async {
    try {
      final response = await http.get(Uri.parse(widget.file.fileUrl));
      if (response.statusCode == 200) {
        Uint8List pdfData = response.bodyBytes;

        pdfControllerPinch = PdfControllerPinch(
          document: PdfDocument.openData(pdfData),
        );

        setState(() {
          isLoading = false;
        });
      } else {
        if (mounted) {
          ShowSnackBar(
              context: context,
              child: Text("حدث خطأ في تحميل الملف",
                  style: AppTextStyles.regular14.copyWith(color: Colors.white)),
              backgroundColor: Colors.red);
        }
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    loadPdf();
    if (mounted) {
      context.read<FileItemCubit>().joinToFileItem(
            courseId: context
                .read<Coursefileviewnavigationsrequirmentsentity>()
                .course
                .id,
            sectionId: context
                .read<Coursefileviewnavigationsrequirmentsentity>()
                .sectionId,
            sectionItemId: context
                .read<Coursefileviewnavigationsrequirmentsentity>()
                .file
                .id,
            joinedByEntity: JoinedByEntity(
              name: getUserData().fullName,
              uid: getUserData().uid,
              joinedDate: DateTime.now(),
              imageUrl: getUserData().profilePicurl,
            ),
          );
    }
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    pdfControllerPinch?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (pdfControllerPinch == null) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return BlocConsumer<FileItemCubit, FileItemState>(
        listener: (context, state) {
          if (state is JoinToFileITemSuccess) {
            ShowSnackBar(
                context: context,
                child: Text("تم الإنضمام بنجاح",
                    style:
                        AppTextStyles.regular14.copyWith(color: Colors.white)),
                backgroundColor: Colors.green);
          } else if (state is JoinToFileITemFailure) {
            ShowSnackBar(
                context: context,
                child: Text(state.errMessage,
                    style:
                        AppTextStyles.regular14.copyWith(color: Colors.white)),
                backgroundColor: Colors.red);
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              Skeletonizer(
                enabled: isLoading,
                child: Column(
                  children: [
                    CourseFileOverView(
                        totalPages: totalPages,
                        pdfControllerPinch: pdfControllerPinch!,
                        currentPage: currentPage),
                    const SizedBox(
                      height: 20,
                    ),
                    Expanded(
                        child: PdfViewPinch(
                            controller: pdfControllerPinch!,
                            onDocumentLoaded: (doc) {
                              totalPages = doc.pagesCount;
                              setState(() {});
                            },
                            onPageChanged: (page) {
                              setState(() {
                                currentPage = page;
                              });
                            }))
                  ],
                ),
              ),
              Visibility(
                visible: state is JoinToFileITemLoading ? true : false,
                child: const Positioned(
                    bottom: 16,
                    left: 16,
                    right: 16,
                    child: addingJoinedByLoadingWidget()),
              )
            ],
          );
        },
      );
    }
  }
}

import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseFileEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CourseFIlePreViewer_Widgets/CourseFileOverView.dart';

class Coursefilepreviewerviewbody extends StatefulWidget {
  const Coursefilepreviewerviewbody({super.key, required this.file});
  final Coursefileentity file;

  @override
  State<Coursefilepreviewerviewbody> createState() =>
      _CoursefilepreviewerviewbodyState();
}

class _CoursefilepreviewerviewbodyState
    extends State<Coursefilepreviewerviewbody> {
  late PdfControllerPinch pdfControllerPinch;
  int totalPages = 0;
  int currentPage = 1;

  @override
  void initState() {
    pdfControllerPinch = PdfControllerPinch(
        document: PdfDocument.openAsset(widget.file.filePath));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CourseFileOverView(
            totalPages: totalPages,
            pdfControllerPinch: pdfControllerPinch,
            currentPage: currentPage),
        const SizedBox(
          height: 20,
        ),
        Expanded(
            child: PdfViewPinch(
                controller: pdfControllerPinch,
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
    );
  }
}

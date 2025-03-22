import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pdfx/pdfx.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseFileEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CourseFIlePreViewer_Widgets/CourseFileOverView.dart';
import 'package:skeletonizer/skeletonizer.dart';

class Coursefilepreviewerviewbody extends StatefulWidget {
  const Coursefilepreviewerviewbody({super.key, required this.file});
  final Coursefileentity file;

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
        throw Exception("Failed to load PDF");
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (pdfControllerPinch == null) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return Skeletonizer(
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
      );
    }
  }
}

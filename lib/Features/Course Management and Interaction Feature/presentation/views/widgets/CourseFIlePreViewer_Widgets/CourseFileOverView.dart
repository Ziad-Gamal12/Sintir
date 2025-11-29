import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pdfx/pdfx.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/constant.dart';
import 'package:sintir/locale_keys.dart';

class CourseFileOverView extends StatelessWidget {
  const CourseFileOverView({
    super.key,
    required this.totalPages,
    required this.pdfControllerPinch,
    required this.currentPage,
  });

  final int totalPages;
  final PdfControllerPinch pdfControllerPinch;
  final int currentPage;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      width: double.infinity,
      decoration: const BoxDecoration(
          color: KMainColor,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8))),
      child: Row(
        children: [
          Text("${LocaleKeys.totalPages}: $totalPages",
              style: AppTextStyles(context)
                  .semiBold14
                  .copyWith(color: Colors.white)),
          const Spacer(),
          SizedBox(
            child: Row(
              children: [
                IconButton(
                    onPressed: () {
                      pdfControllerPinch.nextPage(
                          duration: const Duration(microseconds: 500),
                          curve: Curves.linear);
                    },
                    icon: const Icon(FontAwesomeIcons.arrowRight,
                        color: Colors.white)),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  currentPage.toString(),
                  style: AppTextStyles(context)
                      .semiBold14
                      .copyWith(color: Colors.white),
                ),
                const SizedBox(
                  width: 10,
                ),
                IconButton(
                    onPressed: () {
                      pdfControllerPinch.previousPage(
                          duration: const Duration(microseconds: 500),
                          curve: Curves.linear);
                    },
                    icon: const Icon(
                      FontAwesomeIcons.arrowLeft,
                      color: Colors.white,
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }
}

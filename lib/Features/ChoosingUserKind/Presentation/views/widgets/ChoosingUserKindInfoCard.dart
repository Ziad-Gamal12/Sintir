import 'package:flutter/material.dart';
import 'package:sintir/Features/ChoosingUserKind/Presentation/views/domain/ChoosingUserKindpageViewItemEntity.dart';
import 'package:sintir/Features/ChoosingUserKind/Presentation/views/widgets/ChoosingUserKindButton.dart';
import 'package:sintir/Features/ChoosingUserKind/Presentation/views/widgets/ChoosingUserKindDescription.dart';
import 'package:sintir/Features/ChoosingUserKind/Presentation/views/widgets/ChoosingUserKindTitle.dart';
import 'package:sintir/Features/ChoosingUserKind/Presentation/views/widgets/CustomChoosingUserKindSmoothPageIndicator.dart';

/// Info Card (Text + Description + Indicator + Button)
class ChoosingUserKindInfoCard extends StatelessWidget {
  const ChoosingUserKindInfoCard({
    super.key,
    required this.pages,
    required this.currentPageNotifier,
    required this.pageController,
  });

  final List<ChoosingUserKindpageViewItemEntity> pages;
  final ValueNotifier<int> currentPageNotifier;
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: ValueListenableBuilder<int>(
        valueListenable: currentPageNotifier,
        builder: (context, currentPage, _) {
          final page = pages[currentPage];
          return Column(
            children: [
              ChoosingUserKindTitle(title: page.title),
              const SizedBox(height: 10),
              ChoosingUserKindDescription(description: page.description),
              const Spacer(),
              CustomChoosingUserKindSmoothPageIndicator(
                pageController: pageController,
              ),
              const SizedBox(height: 30),
              ChoosingUserKindButton(currentPage: currentPage),
            ],
          );
        },
      ),
    );
  }
}

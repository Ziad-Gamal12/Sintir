import 'package:flutter/material.dart';
import 'package:sintir/Features/ChoosingUserKind/Presentation/views/domain/ChoosingUserKindpageViewItemEntity.dart';
import 'package:sintir/Features/ChoosingUserKind/Presentation/views/widgets/ChoosingUserKindButton.dart';
import 'package:sintir/Features/ChoosingUserKind/Presentation/views/widgets/CustomChoosingUserKindSmoothPageIndicator.dart';

/// Info Card (Text + Description + Indicator + Button)
class PageIndicatorAndButton extends StatelessWidget {
  const PageIndicatorAndButton({
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
    return ValueListenableBuilder<int>(
      valueListenable: currentPageNotifier,
      builder: (context, currentPage, _) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CustomChoosingUserKindSmoothPageIndicator(
              pageController: pageController,
            ),
            const SizedBox(height: 16),
            ChoosingUserKindButton(currentPage: currentPage),
          ],
        );
      },
    );
  }
}

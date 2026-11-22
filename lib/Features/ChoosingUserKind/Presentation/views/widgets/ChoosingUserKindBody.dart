import 'package:flutter/material.dart';
import 'package:sintir/Core/responsive/breakpoints.dart';
import 'package:sintir/Features/ChoosingUserKind/domain/ChoosingUserKindpageViewItemEntity.dart';
import 'package:sintir/Features/ChoosingUserKind/Presentation/views/widgets/ChoosingUserKindWideBody.dart';
import 'package:sintir/Features/ChoosingUserKind/Presentation/views/widgets/CustomPageView.dart';
import 'package:sintir/Features/ChoosingUserKind/Presentation/views/widgets/PageIndicatorAndButton.dart';
import 'package:sintir/constant.dart';

class ChoosingUserKindBody extends StatefulWidget {
  const ChoosingUserKindBody({super.key});

  @override
  State<ChoosingUserKindBody> createState() => _ChoosingUserKindBodyState();
}

class _ChoosingUserKindBodyState extends State<ChoosingUserKindBody> {
  late final PageController pageController;
  final ValueNotifier<int> currentPageNotifier = ValueNotifier(0);
  late final List<ChoosingUserKindpageViewItemEntity> pages;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: 0);
    pages = ChoosingUserKindpageViewItemEntity.toList();
  }

  @override
  void dispose() {
    pageController.dispose();
    currentPageNotifier.dispose();
    super.dispose();
  }

  /// After a rotation from the wide layout, show the role picked there.
  void _syncPageView() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || !pageController.hasClients) return;
      final target = currentPageNotifier.value;
      if (pageController.page?.round() != target) {
        pageController.jumpToPage(target);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Tablets (and phones in landscape): both roles side by side.
        if (constraints.maxWidth >= Breakpoints.medium) {
          return ChoosingUserKindWideBody(
            pages: pages,
            selectedNotifier: currentPageNotifier,
          );
        }

        _syncPageView();
        return Padding(
          padding: const EdgeInsets.symmetric(
            vertical: KVerticalPadding,
            horizontal: KHorizontalPadding,
          ),
          child: Column(
            children: [
              Expanded(
                flex: 6,
                child: CustomPageview(
                  controller: pageController,
                  onPageChanged: (index) => currentPageNotifier.value = index,
                ),
              ),
              Expanded(
                flex: 2,
                child: PageIndicatorAndButton(
                  pages: pages,
                  currentPageNotifier: currentPageNotifier,
                  pageController: pageController,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

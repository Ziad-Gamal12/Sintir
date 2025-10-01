import 'package:flutter/material.dart';
import 'package:sintir/Features/ChoosingUserKind/Presentation/views/domain/ChoosingUserKindpageViewItemEntity.dart';
import 'package:sintir/Features/ChoosingUserKind/Presentation/views/widgets/ChoosingUserKindInfoCard.dart';
import 'package:sintir/Features/ChoosingUserKind/Presentation/views/widgets/CustomPageView.dart';
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 30,
        horizontal: KHorizontalPadding,
      ),
      child: Column(
        children: [
          Expanded(
            flex: 6,
            child: Custompageview(
              controller: pageController,
              onPageChanged: (index) => currentPageNotifier.value = index,
            ),
          ),
          Expanded(
            flex: 4,
            child: ChoosingUserKindInfoCard(
              pages: pages,
              currentPageNotifier: currentPageNotifier,
              pageController: pageController,
            ),
          ),
        ],
      ),
    );
  }
}

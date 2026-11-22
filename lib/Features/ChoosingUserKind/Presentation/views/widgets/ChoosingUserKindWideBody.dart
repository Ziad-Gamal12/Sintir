// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/ChoosingUserKind/domain/ChoosingUserKindpageViewItemEntity.dart';
import 'package:sintir/Features/ChoosingUserKind/Presentation/views/widgets/ChoosingUserKindButton.dart';
import 'package:sintir/constant.dart';
import 'package:svg_flutter/svg.dart';

class ChoosingUserKindWideBody extends StatelessWidget {
  const ChoosingUserKindWideBody({
    super.key,
    required this.pages,
    required this.selectedNotifier,
  });

  final List<ChoosingUserKindpageViewItemEntity> pages;
  final ValueNotifier<int> selectedNotifier;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: selectedNotifier,
      builder: (context, selected, _) {
        return Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 32),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 880),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 400,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      spacing: 24,
                      children: [
                        for (var i = 0; i < pages.length; i++)
                          Expanded(
                            child: _RoleCard(
                              item: pages[i],
                              selected: selected == i,
                              onTap: () => selectedNotifier.value = i,
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 400),
                    child: ChoosingUserKindButton(currentPage: selected),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _RoleCard extends StatelessWidget {
  const _RoleCard({
    required this.item,
    required this.selected,
    required this.onTap,
  });

  final ChoosingUserKindpageViewItemEntity item;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final idleBorder = isDark ? Colors.white10 : const Color(0xFFE4E6E8);

    return Semantics(
      button: true,
      selected: selected,
      inMutuallyExclusiveGroup: true,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: selected
              ? Color.alphaBlend(
                  KMainColor.withValues(alpha: .06),
                  theme.cardColor,
                )
              : theme.cardColor,
          borderRadius: BorderRadius.circular(28),
          border: Border.all(
            color: selected ? KMainColor : idleBorder,
            width: selected ? 2 : 1,
          ),
          boxShadow: selected
              ? [
                  BoxShadow(
                    color: KMainColor.withValues(alpha: .18),
                    blurRadius: 30,
                    offset: const Offset(0, 12),
                  ),
                ]
              : null,
        ),
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(28),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(28, 32, 28, 28),
                  child: Column(
                    children: [
                      // The illustration takes whatever height is left.
                      Expanded(
                        child: SvgPicture.asset(
                          item.image,
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(item.title, style: AppTextStyles(context).bold24),
                      const SizedBox(height: 8),
                      Text(
                        item.description,
                        textAlign: TextAlign.center,
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles(context).regular14,
                      ),
                    ],
                  ),
                ),
                if (selected)
                  const PositionedDirectional(
                    top: 16,
                    start: 16,
                    child: CircleAvatar(
                      radius: 16,
                      backgroundColor: KMainColor,
                      child: Icon(
                        Icons.check_rounded,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

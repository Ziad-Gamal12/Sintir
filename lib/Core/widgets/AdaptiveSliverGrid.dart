import 'package:flutter/material.dart';

class AdaptiveSliverGrid extends StatelessWidget {
  const AdaptiveSliverGrid({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.minItemWidth = 340,
    this.maxColumns = 3,
    this.spacing = 12,
  });

  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;
  final double minItemWidth;
  final int maxColumns;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    return SliverLayoutBuilder(
      builder: (context, constraints) {
        final columns =
            ((constraints.crossAxisExtent + spacing) / (minItemWidth + spacing))
                .floor()
                .clamp(1, maxColumns)
                .toInt();

        if (columns == 1) {
          return SliverList.separated(
            itemCount: itemCount,
            itemBuilder: itemBuilder,
            separatorBuilder: (_, __) => SizedBox(height: spacing),
          );
        }

        return SliverList.separated(
          itemCount: (itemCount / columns).ceil(),
          separatorBuilder: (_, __) => SizedBox(height: spacing),
          itemBuilder: (context, row) {
            return IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  for (var c = 0; c < columns; c++) ...[
                    if (c > 0) SizedBox(width: spacing),
                    Expanded(
                      child: row * columns + c < itemCount
                          ? itemBuilder(context, row * columns + c)
                          : const SizedBox.shrink(),
                    ),
                  ],
                ],
              ),
            );
          },
        );
      },
    );
  }
}

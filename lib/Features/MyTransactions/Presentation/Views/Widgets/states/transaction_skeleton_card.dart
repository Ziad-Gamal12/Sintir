import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class TransactionSkeletonCard extends StatelessWidget {
  const TransactionSkeletonCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(16, 6, 16, 6),
      child: Skeletonizer(
        enabled: true,
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: theme.cardColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: theme.dividerColor.withValues(alpha: .2)),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  const Bone.square(
                    size: 44,
                    borderRadius: BorderRadius.all(Radius.circular(13)),
                  ),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Bone.text(words: 2),
                        SizedBox(height: 6),
                        Bone.text(words: 2),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  const SizedBox(
                    width: 92,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Bone.text(words: 2),
                        SizedBox(height: 6),
                        Bone(
                          width: 58,
                          height: 18,
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Divider(height: 1),
              ),
              const Wrap(
                alignment: WrapAlignment.spaceBetween,
                spacing: 8,
                runSpacing: 8,
                children: [
                  SizedBox(
                    width: 76,
                    child: Bone(
                      height: 16,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  SizedBox(
                    width: 92,
                    child: Bone(
                      height: 16,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  SizedBox(
                    width: 58,
                    child: Bone(
                      height: 16,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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
          child: Column(children: [
            Row(children: [
              const Bone.square(
                  size: 44,
                  borderRadius: BorderRadius.all(Radius.circular(13))),
              const SizedBox(width: 12),
              const Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Bone.text(words: 2),
                    SizedBox(height: 6),
                    Bone.text(words: 3)
                  ])),
              const SizedBox(width: 20),
              const Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Bone.text(words: 2),
                    SizedBox(height: 6),
                    Bone(
                        width: 58,
                        height: 18,
                        borderRadius: BorderRadius.all(Radius.circular(12)))
                  ]),
            ]),
            const SizedBox(height: 16),
            const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Bone.text(words: 2),
                  Bone.text(words: 3),
                  Bone(width: 60, height: 18)
                ]),
          ]),
        ),
      ),
    );
  }
}

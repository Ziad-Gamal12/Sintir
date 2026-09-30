import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ReportsListSkeleton extends StatelessWidget {
  const ReportsListSkeleton({super.key, this.count = 5, this.asSliver = false});
  final int count;
  final bool asSliver;

  Widget _item(BuildContext context, int index) => Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Skeletonizer(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(children: [
                    Bone(width: 90, height: 22),
                    Spacer(),
                    Bone(width: 110, height: 22),
                  ]),
                  const SizedBox(height: 12),
                  const Bone(width: double.infinity, height: 14),
                  const SizedBox(height: 7),
                  const Bone(width: double.infinity, height: 14),
                  const SizedBox(height: 13),
                  const Divider(),
                  Row(children: [
                    const Bone(width: 100, height: 14),
                    const Spacer(),
                    const Bone(width: 65, height: 14),
                  ]),
                ],
              ),
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) => asSliver
      ? SliverPadding(
          padding: const EdgeInsetsDirectional.fromSTEB(12, 8, 12, 16),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(_item, childCount: count),
          ),
        )
      : ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: count,
          itemBuilder: _item,
        );
}

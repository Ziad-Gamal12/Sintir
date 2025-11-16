import 'package:flutter/material.dart';
import 'package:sintir/Core/widgets/CustomListORGridTextHeader.dart';
import 'package:sintir/Features/Home/presentation/views/widgets/HomeViewBodyAppBar.dart';
import 'package:sintir/Features/Home/presentation/views/widgets/PopularCoursesSection.dart';
import 'package:sintir/Features/Home/presentation/views/widgets/RecentCoursesSection.dart';
import 'package:sintir/Features/Home/presentation/views/widgets/UserInterestedCoursesSection.dart';
import 'package:sintir/constant.dart';

class HomeViewBodyBuilder extends StatelessWidget {
  const HomeViewBodyBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: KHorizontalPadding,
      ),
      child: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(child: HomeViewBodyAppBar()),
          const SliverToBoxAdapter(child: SizedBox(height: 20)),
          const UserInterestedCoursesSection(),
          const SliverToBoxAdapter(child: SizedBox(height: 20)),
          const PopularCoursesSection(),
          const SliverToBoxAdapter(child: SizedBox(height: 20)),
          SliverToBoxAdapter(
            child: Column(
              children: [
                CustomListORGridTextHeader(text: "أحدث الكورسات"),
                const SizedBox(height: 10),
              ],
            ),
          ),
          const RecentCoursesSection(),
        ],
      ),
    );
  }
}

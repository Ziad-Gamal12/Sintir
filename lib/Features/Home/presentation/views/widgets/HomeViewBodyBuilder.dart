import 'package:flutter/material.dart';
import 'package:sintir/Features/Home/presentation/views/widgets/HomeViewBodyAppBar.dart';
import 'package:sintir/Features/Home/presentation/views/widgets/NewestCoursesHeader.dart';
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
    return const Padding(
      padding: EdgeInsets.symmetric(
        horizontal: KHorizontalPadding,
        vertical: KVerticalPadding,
      ),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: HomeViewBodyAppBar()),
          SliverToBoxAdapter(child: SizedBox(height: 24)),
          UserInterestedCoursesSection(),
          SliverToBoxAdapter(child: SizedBox(height: 24)),
          PopularCoursesSection(),
          SliverToBoxAdapter(child: SizedBox(height: 24)),
          SliverToBoxAdapter(
            child: NewestCoursesHeader(),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 12)),
          RecentCoursesSection(),
        ],
      ),
    );
  }
}

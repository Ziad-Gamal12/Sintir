import 'package:flutter/material.dart';
import 'package:sintir/Features/Home/presentation/views/widgets/HomeViewBodyAppBar.dart';
import 'package:sintir/Features/Home/presentation/views/widgets/NewestCoursesHeader.dart';
import 'package:sintir/Features/Home/presentation/views/widgets/PopularCoursesSection.dart';
import 'package:sintir/Features/Home/presentation/views/widgets/RecentCoursesSection.dart';
import 'package:sintir/Features/Home/presentation/views/widgets/UserInterestedCoursesSection.dart';

class HomeViewBodyBuilder extends StatelessWidget {
  const HomeViewBodyBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16, right: 16, top: 20, bottom: 92),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: HomeViewBodyAppBar()),
          SliverToBoxAdapter(child: SizedBox(height: 16)),
          UserInterestedCoursesSection(),
          SliverToBoxAdapter(child: SizedBox(height: 16)),
          PopularCoursesSection(),
          SliverToBoxAdapter(child: SizedBox(height: 16)),
          SliverToBoxAdapter(child: NewestCoursesHeader()),
          SliverToBoxAdapter(child: SizedBox(height: 12)),
          RecentCoursesSection(),
        ],
      ),
    );
  }
}

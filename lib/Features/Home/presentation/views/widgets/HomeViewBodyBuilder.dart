import 'package:flutter/material.dart';
import 'package:sintir/Core/responsive/breakpoints.dart';
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
      padding: EdgeInsets.only(
        top: 20,
        bottom: context.hasSideNavigation ? 20 : 92,
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final horizontal = EdgeInsets.symmetric(
            horizontal: ContentWidth.gutter(
              constraints.maxWidth,
              ContentWidth.page,
            ),
          );
          return CustomScrollView(
            slivers: [
              SliverPadding(
                padding: horizontal,
                sliver: const SliverToBoxAdapter(child: HomeViewBodyAppBar()),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 16)),
              SliverPadding(
                padding: horizontal,
                sliver: const UserInterestedCoursesSection(),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 16)),
              SliverPadding(
                padding: horizontal,
                sliver: const PopularCoursesSection(),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 16)),
              SliverPadding(
                padding: horizontal,
                sliver: const SliverToBoxAdapter(child: NewestCoursesHeader()),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 12)),
              SliverPadding(
                padding: horizontal,
                sliver: const RecentCoursesSection(),
              ),
            ],
          );
        },
      ),
    );
  }
}

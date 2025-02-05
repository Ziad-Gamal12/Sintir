import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/Variables.dart';
import 'package:sintir/Core/widgets/CustomListORGridTextHeader.dart';
import 'package:sintir/Features/Favorites/presentation/views/widgets/FavouriteBooksListView.dart';
import 'package:sintir/Features/Favorites/presentation/views/widgets/FavouriteCoursesGrideView.dart';
import 'package:sintir/constant.dart';

class FavoritesviewBody extends StatelessWidget {
  const FavoritesviewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: KHorizontalPadding),
                child: CustomListORGridTextHeader(
                  text: "كتبي المفضلة",
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Favouritebookslistview(),
              const SizedBox(
                height: 17,
              ),
            ],
          ),
        ),
        const SliverToBoxAdapter(
          child: Divider(
            color: Colors.black,
            height: 1,
          ),
        ),
        SliverToBoxAdapter(
          child: Column(
            children: [
              const SizedBox(
                height: 14,
              ),
              Padding(
                padding: const EdgeInsets.only(right: KHorizontalPadding),
                child: CustomListORGridTextHeader(
                  text: "كورساتي المفضلة",
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: KHorizontalPadding),
          sliver: Favouritecoursesgrideview(
            courses: Variables.TestCoursesList,
          ),
        )
      ],
    );
  }
}

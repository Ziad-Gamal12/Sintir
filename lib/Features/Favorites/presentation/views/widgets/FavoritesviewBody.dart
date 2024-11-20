import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/Variables.dart';
import 'package:sintir/Features/Favorites/presentation/views/widgets/FavouriteBooksListView.dart';
import 'package:sintir/Features/Favorites/presentation/views/widgets/FavouriteCoursesGrideView.dart';
import 'package:sintir/Features/Favorites/presentation/views/widgets/customFavoriteBooksListViewHeader.dart';
import 'package:sintir/Features/Favorites/presentation/views/widgets/customFavoriteCourseGrideviewHeader.dart';
import 'package:sintir/constant.dart';

class FavoritesviewBody extends StatelessWidget {
  const FavoritesviewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: Variables.scrollController,
      slivers: const [
        SliverToBoxAdapter(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(right: KHorizontalPadding),
                child: Customfavoritebookslistviewheader(),
              ),
              SizedBox(
                height: 10,
              ),
              Favouritebookslistview(),
              SizedBox(
                height: 17,
              ),
              Divider(
                color: Colors.black,
                height: 1,
              )
            ],
          ),
        ),
        SliverToBoxAdapter(
          child: Column(
            children: [
              SizedBox(
                height: 14,
              ),
              Padding(
                padding: EdgeInsets.only(right: KHorizontalPadding),
                child: Customfavoritecoursegrideviewheader(),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: KHorizontalPadding),
          sliver: Favouritecoursesgrideview(),
        )
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/widgets/CustomEmptyWidget.dart';
import 'package:sintir/Features/Favorites/presentation/views/Manager/favourites_cubit/favourites_cubit.dart';
import 'package:sintir/Features/Favorites/presentation/views/widgets/FavoritesviewBodyGridView.dart';
import 'package:sintir/constant.dart';

class FavoritesviewBody extends StatelessWidget {
  const FavoritesviewBody({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    List<CourseEntity> courses = context.watch<FavouritesCubit>().favorites;
    return BlocBuilder<FavouritesCubit, FavouritesState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: KHorizontalPadding, vertical: KVerticalPadding),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: courses.isEmpty
                ? CustomEmptyWidget(
                    text: "قم بإضافة دورات للمفضلة",
                  )
                : FavoritesviewBodyGridView(width: width, courses: courses),
          ),
        );
      },
    );
  }
}

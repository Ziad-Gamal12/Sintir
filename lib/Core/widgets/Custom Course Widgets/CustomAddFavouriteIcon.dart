// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/helper/GetUserData.dart';
import 'package:sintir/Features/Auth/Domain/Entities/UserEntity.dart';
import 'package:sintir/Features/Favorites/presentation/views/Manager/favourites_cubit/favourites_cubit.dart';

class CustomAddFavouriteIcon extends StatefulWidget {
  const CustomAddFavouriteIcon({
    super.key,
    required this.courseEntity,
  });
  final CourseEntity courseEntity;

  @override
  State<CustomAddFavouriteIcon> createState() => _CustomAddFavouriteIconState();
}

class _CustomAddFavouriteIconState extends State<CustomAddFavouriteIcon>
    with SingleTickerProviderStateMixin {
  late UserEntity user;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    user = getUserData();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap(bool isFav) async {
    if (isFav) {
      await context
          .read<FavouritesCubit>()
          .removeFromFavorites(course: widget.courseEntity, userId: user.uid);
      _controller.reverse();
    } else {
      await context
          .read<FavouritesCubit>()
          .addToFavorites(course: widget.courseEntity, userId: user.uid);
      _controller.forward(from: 0.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isFav = context.select<FavouritesCubit, bool>(
      (cubit) => cubit.favoritesMap.containsKey(widget.courseEntity.id),
    );

    return ScaleTransition(
      scale: _scaleAnimation,
      child: CircleAvatar(
        radius: 18,
        backgroundColor: Colors.transparent.withOpacity(.4),
        child: IconButton(
          onPressed: () => _handleTap(isFav),
          icon: AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            transitionBuilder: (child, animation) =>
                ScaleTransition(scale: animation, child: child),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Icon(
                isFav ? FontAwesomeIcons.solidHeart : FontAwesomeIcons.heart,
                key: ValueKey<bool>(isFav),
                color: isFav ? Colors.red : Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

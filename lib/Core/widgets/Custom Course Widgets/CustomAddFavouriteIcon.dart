// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/helper/GetUserData.dart';
import 'package:sintir/Core/helper/ShowSnackBar.dart';
import 'package:sintir/Features/Auth/Domain/Entities/UserEntity.dart';
import 'package:sintir/Features/Favorites/presentation/views/Manager/favourites_cubit/favourites_cubit.dart';

class CustomAddFavouriteIcon extends StatefulWidget {
  const CustomAddFavouriteIcon({super.key, required this.courseEntity});
  final CourseEntity courseEntity;

  @override
  State<CustomAddFavouriteIcon> createState() => _CustomAddFavouriteIconState();
}

class _CustomAddFavouriteIconState extends State<CustomAddFavouriteIcon>
    with SingleTickerProviderStateMixin {
  late final UserEntity user;
  late final AnimationController _controller;
  late final Animation<double> _scale;

  bool _isBusy = false;

  @override
  void initState() {
    super.initState();
    user = getUserData();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 380),
    );

    _scale = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(
          begin: 1.0,
          end: 1.25,
        ).chain(CurveTween(curve: Curves.easeOut)),
        weight: 40,
      ),
      TweenSequenceItem(
        tween: Tween(
          begin: 1.25,
          end: 1.0,
        ).chain(CurveTween(curve: Curves.elasticOut)),
        weight: 60,
      ),
    ]).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _handleTap(bool isFav) async {
    if (_isBusy) return;
    _isBusy = true;

    final cubit = context.read<FavouritesCubit>();
    try {
      if (isFav) {
        await cubit.removeFromFavorites(
          course: widget.courseEntity,
          userId: user.uid,
        );
      } else {
        await cubit.addToFavorites(
          course: widget.courseEntity,
          userId: user.uid,
        );
      }

      if (!mounted) return;
      final state = cubit.state;
      if (state is AddToFavoritesFailureState) {
        CustomSnackBar.show(
          context,
          message: state.errMessage,
          type: SnackType.error,
        );
      } else if (state is RemoveFromFavoritesFailureState) {
        CustomSnackBar.show(
          context,
          message: state.errMessage,
          type: SnackType.error,
        );
      } else if (!isFav) {
        HapticFeedback.lightImpact();
        _controller.forward(from: 0);
      }
    } finally {
      _isBusy = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isFav = context.select<FavouritesCubit, bool>(
      (cubit) => cubit.favoritesMap.containsKey(widget.courseEntity.id),
    );

    return ScaleTransition(
      scale: _scale,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => _handleTap(isFav),
        child: SizedBox.square(
          dimension: 44,
          child: Center(
            child: Container(
              width: 32,
              height: 32,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: .45),
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white.withValues(alpha: .15),
                  width: .5,
                ),
              ),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 220),
                transitionBuilder: (child, animation) =>
                    ScaleTransition(scale: animation, child: child),
                child: FaIcon(
                  isFav ? FontAwesomeIcons.solidHeart : FontAwesomeIcons.heart,
                  key: ValueKey<bool>(isFav),
                  size: 15,
                  color: isFav ? Colors.redAccent : Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

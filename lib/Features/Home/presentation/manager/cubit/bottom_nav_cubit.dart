import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'bottom_nav_state.dart';

class BottomNavCubit extends Cubit<BottomNavState> {
  BottomNavCubit() : super(BottomNavInitial());
  int currentIndex = 0;
  final Set<int> visited = {0};
  void changeIndex(int index) {
    if (index == currentIndex) return;
    currentIndex = index;
    visited.add(index);

    emit(BottomNavChanged());
  }

  void navigateToProfile() {
    if (currentIndex == 3) return;
    currentIndex = 3;
    emit(BottomNavChanged());
  }
}

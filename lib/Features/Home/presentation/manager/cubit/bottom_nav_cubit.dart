import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:sintir/Features/Favorites/presentation/views/FavoritesView.dart';
import 'package:sintir/Features/Home/presentation/views/widgets/Homeview_Body.dart';
import 'package:sintir/Features/Profile/Presentation/Views/ProfileView.dart';
import 'package:sintir/Features/Search/Presentation/Views/SearchView.dart';

part 'bottom_nav_state.dart';

class BottomNavCubit extends Cubit<BottomNavState> {
  BottomNavCubit() : super(BottomNavInitial());
  int currentIndex = 0;
  List<Widget> screens = [
    HomeViewBody(),
    const SearchView(),
    Favoritesview(
      isPopUp: false,
    ),
    const ProfileView()
  ];
  void changeIndex(int index) {
    if (index == currentIndex) return;
    currentIndex = index;
    emit(BottomNavChanged());
  }

  void navigateToProfile() {
    if (currentIndex == 3) return;
    currentIndex = 3;
    emit(BottomNavChanged());
  }
}

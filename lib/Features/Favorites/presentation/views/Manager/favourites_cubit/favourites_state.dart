part of 'favourites_cubit.dart';

@immutable
sealed class FavouritesState {}

final class FavouritesInitial extends FavouritesState {}
// getFavorites

final class GetFavoritesSuccessState extends FavouritesState {
  final List<CourseEntity> favorites;
  GetFavoritesSuccessState({required this.favorites});
}

final class GetFavoritesFailureState extends FavouritesState {
  final String errMessage;
  GetFavoritesFailureState({required this.errMessage});
}

final class GetFavoritesLoadingState extends FavouritesState {}

// addToFavorites
final class AddToFavoritesSuccessState extends FavouritesState {}

final class AddToFavoritesFailureState extends FavouritesState {
  final String errMessage;
  AddToFavoritesFailureState({required this.errMessage});
}

// removeFromFavorites
final class RemoveFromFavoritesSuccessState extends FavouritesState {}

final class RemoveFromFavoritesFailureState extends FavouritesState {
  final String errMessage;
  RemoveFromFavoritesFailureState({required this.errMessage});
}

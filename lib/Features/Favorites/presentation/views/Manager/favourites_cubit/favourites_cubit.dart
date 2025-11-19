import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Features/Favorites/Domain/Repos/FavoritesRepo.dart';

part 'favourites_state.dart';

class FavouritesCubit extends Cubit<FavouritesState> {
  FavouritesCubit({required this.favoritesRepo}) : super(FavouritesInitial());

  final FavoritesRepo favoritesRepo;

  List<CourseEntity> favorites = [];
  Map<String, bool> favoritesMap = {};

  Future<void> getFavorites({required String userId}) async {
    emit(GetFavoritesLoadingState());
    final result = await favoritesRepo.getFavorites(userId: userId);

    result.fold(
      (failure) => emit(GetFavoritesFailureState(errMessage: failure.message)),
      (courses) {
        favorites = courses;

        // 🔥 هنا أهم خطوة — بناء map سريعة للبحث
        favoritesMap = {
          for (var c in courses) c.id: true,
        };

        emit(GetFavoritesSuccessState(favorites: courses));
      },
    );
  }

  Future<void> addToFavorites({
    required String userId,
    required CourseEntity course,
  }) async {
    final result =
        await favoritesRepo.addToFavorites(userId: userId, course: course);

    result.fold(
      (failure) =>
          emit(AddToFavoritesFailureState(errMessage: failure.message)),
      (_) {
        favorites.add(course);
        favoritesMap[course.id] = true;

        emit(AddToFavoritesSuccessState());
      },
    );
  }

  Future<void> removeFromFavorites({
    required String userId,
    required CourseEntity course,
  }) async {
    final result =
        await favoritesRepo.removeFromFavorites(userId: userId, course: course);

    result.fold(
      (failure) =>
          emit(RemoveFromFavoritesFailureState(errMessage: failure.message)),
      (_) {
        favorites.removeWhere((c) => c.id == course.id);
        favoritesMap.remove(course.id);

        emit(RemoveFromFavoritesSuccessState());
      },
    );
  }
}

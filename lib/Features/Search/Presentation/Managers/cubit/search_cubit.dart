import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sintir/Features/Search/Domain/Entities/SearchResponse.dart';
import 'package:sintir/Features/Search/Domain/Repos/SearchRepo.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit({
    required this.searchRepo,
  }) : super(SearchInitial());
  final SearchRepo searchRepo;

  Future<void> search({
    required String keyword,
  }) async {
    emit(SearchLoading());
    final result = await searchRepo.search(
      keyword: keyword,
    );

    result.fold(
      (failure) => emit(SearchFailure(errorMessage: failure.message)),
      (searchResponse) => emit(SearchSuccess(searchResponse: searchResponse)),
    );
  }

  Future<void> getDefaultCourses() async {
    emit(GetDefaultCoursesLoading());
    final result = await searchRepo.getDefaultCourses();
    result.fold(
      (failure) =>
          emit(GetDefaultCoursesFailure(errorMessage: failure.message)),
      (searchResponse) =>
          emit(GetDefaultCoursesSuccess(searchResponse: searchResponse)),
    );
  }

  Future<void> getDefaultTeachers() async {
    emit(GetDefaultTeachersLoading());
    final result = await searchRepo.getDefaultTeachers();
    result.fold(
      (failure) =>
          emit(GetDefaultTeachersFailure(errorMessage: failure.message)),
      (searchResponse) =>
          emit(GetDefaultTeachersSuccess(searchResponse: searchResponse)),
    );
  }
}

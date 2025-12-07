import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestEntity.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Core/repos/Test-Item-Repo/TestItemRepo.dart';

part 'update_test_state.dart';

class UpdateTestCubit extends Cubit<UpdateTestState> {
  UpdateTestCubit({required this.testitemrepo}) : super(UpdateTestInitial());
  final Testitemrepo testitemrepo;
  void updateTestItem(
      {required CourseTestEntity test,
      required String courseId,
      required String sectionId}) async {
    emit(UpdateTestItemLoading());
    Either<Failure, void> result = await testitemrepo.updateTest(
        test: test, courseId: courseId, sectionId: sectionId);
    result.fold((failure) {
      emit(UpdateTestItemFailure(errMessage: failure.message));
    }, (sucUpdateCourseSectionsFailurecess) {
      emit(UpdateTestItemSuccess());
    });
  }
}

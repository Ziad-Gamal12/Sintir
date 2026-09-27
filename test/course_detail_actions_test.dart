import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/entities/FetchDataResponses/GetCourseResonseEntity.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Core/repos/AssetsPickerRepo/AssetsPickerRepo.dart';
import 'package:sintir/Core/repos/CoursesRepo/CoursesRepo.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/course_detail_actions.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/UpdateCourseCubit/Update_Course_Cubit.dart';

void main() {
  late _TestUpdateCourseCubit cubit;
  late CourseEntity course;

  setUp(() {
    cubit = _TestUpdateCourseCubit();
    course = CourseEntity.empty()..state = 'Published';
  });

  tearDown(() async => cubit.close());

  Future<void> pumpActions(WidgetTester tester) async {
    await tester.pumpWidget(
      BlocProvider<UpdateCourseCubit>.value(
        value: cubit,
        child: MaterialApp(
          home: Scaffold(body: CourseDetailActions(course: course)),
        ),
      ),
    );
  }

  testWidgets('archive selector disables the action while state is updating',
      (tester) async {
    await pumpActions(tester);
    expect(tester.widget<OutlinedButton>(find.byType(OutlinedButton)).onPressed,
        isNotNull);

    cubit.emitForTest(UpdateCourseStateLoading());
    await tester.pump();

    expect(tester.widget<OutlinedButton>(find.byType(OutlinedButton)).onPressed,
        isNull);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    cubit.emitForTest(UpdateCourseStateFailure(errmessage: 'Update failed'));
    await tester.pump();

    expect(tester.widget<OutlinedButton>(find.byType(OutlinedButton)).onPressed,
        isNotNull);
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });

  testWidgets('edit loading disables edit without showing archive spinner',
      (tester) async {
    await pumpActions(tester);

    cubit.emitForTest(UpdateCourseLoading());
    await tester.pump();

    expect(tester.widget<FilledButton>(find.byType(FilledButton)).onPressed,
        isNull);
    expect(tester.widget<OutlinedButton>(find.byType(OutlinedButton)).onPressed,
        isNotNull);
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });
}

class _TestUpdateCourseCubit extends UpdateCourseCubit {
  _TestUpdateCourseCubit()
      : super(
          coursesrepo: _UnusedCoursesRepo(),
          assetspickerrepo: _UnusedAssetsPickerRepo(),
        );

  void emitForTest(UpdateCourseState state) => emit(state);
}

class _UnusedCoursesRepo implements Coursesrepo {
  @override
  Future<Either<Failure, void>> addCourse(
          {required CourseEntity courseEntity}) =>
      throw UnimplementedError();

  @override
  Future<Either<Failure, GetCoursesResonseEntity>> getMyCourses(
          {required bool isPaginate}) =>
      throw UnimplementedError();

  @override
  Future<Either<Failure, GetCoursesResonseEntity>> getPopularCourses(
          {required bool isPaginate}) =>
      throw UnimplementedError();

  @override
  Future<Either<Failure, GetCoursesResonseEntity>> getRecentCourses(
          {required bool isPaginate}) =>
      throw UnimplementedError();

  @override
  Future<Either<Failure, GetCoursesResonseEntity>> getStudentInterestedCourses(
          {required bool isPaginate, required String educationlevel}) =>
      throw UnimplementedError();

  @override
  Future<Either<Failure, GetCoursesResonseEntity>> getTeaceherInterestedCourses(
          {required bool isPaginate, required String subject}) =>
      throw UnimplementedError();

  @override
  Future<Either<Failure, void>> updateCourse(
          {required CourseEntity courseEntity}) =>
      throw UnimplementedError();

  @override
  Future<Either<Failure, String>> uplaodFile({required File file}) =>
      throw UnimplementedError();
}

class _UnusedAssetsPickerRepo implements Assetspickerrepo {
  @override
  Future<Either<Failure, File>> pickFile() => throw UnimplementedError();

  @override
  Future<Either<Failure, File>> pickImageFromCamera() =>
      throw UnimplementedError();

  @override
  Future<Either<Failure, File>> pickImageFromGallery() =>
      throw UnimplementedError();

  @override
  Future<Either<Failure, File>> pickVideoFromCamera() =>
      throw UnimplementedError();

  @override
  Future<Either<Failure, File>> pickVideoFromGallery() =>
      throw UnimplementedError();
}

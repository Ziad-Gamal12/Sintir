// ignore_for_file: non_constant_identifier_names, file_names

import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/ContentCreaterEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/utils/Backend_EndPoints.dart';

abstract class Variables {
  static GlobalKey<ScaffoldState> courseDeatilsViewScaffoldKey =
      GlobalKey<ScaffoldState>();
  static GlobalKey<FormState> AddCourseSectionVideoItemFormKey =
      GlobalKey<FormState>();
  static GlobalKey<FormState> AddCourseSectionFormKey = GlobalKey<FormState>();
  static GlobalKey<ScaffoldState> HomeViewScaffoldKey =
      GlobalKey<ScaffoldState>();
  static GlobalKey<ScaffoldState> DisplaycoursevedioveiwScaffoldKey =
      GlobalKey<ScaffoldState>();
  static GlobalKey<FormState> AddCourseSectionSQLtestFormKey =
      GlobalKey<FormState>();
  static TextEditingController AddCourseCourseNameController =
      TextEditingController();
  static TextEditingController AddCourseCourseDescriptionController =
      TextEditingController();
  static TextEditingController AddCourseCourseLevelController =
      TextEditingController();
  static TextEditingController AddCourseCourseSubjectController =
      TextEditingController();
  static TextEditingController AddCourseCourseLanguageController =
      TextEditingController();
  static TextEditingController AddCourseCoursePriceController =
      TextEditingController();
  static TextEditingController AddCourseCoursePhoneController =
      TextEditingController();
  static TextEditingController AddCourseCourseCodeController =
      TextEditingController();
  static TextEditingController AddCourseCourseTextContentController =
      TextEditingController();
  static TextEditingController AddCoursesectionNameController =
      TextEditingController();
  static TextEditingController AddCoursesesectionDescriptionController =
      TextEditingController();
  static TextEditingController AddsqlTestName = TextEditingController();
  static TextEditingController AddsqlTestDuration = TextEditingController();
  static CourseEntity courseEntity = CourseEntity(
    studentsCount: 6,
    state: BackendEndpoints.coursePublishedState,
    id: "12345567",
    posterUrl:
        "https://img.freepik.com/free-psd/e-learning-online-courses-poster-template_23-2149109793.jpg",
    title: "أساسيات دمج الصور",
    description:
        "في كريتيڤز إكس بنحقق معادلة صعبة، معادلة إنك تستمتع و في نفس الوقت تستفيد .",
    price: 120,
    language: "العربيه",
    postedDate: "2022-12-12",
    contentcreaterentity: Contentcreaterentity(
        name: "Adel Gamal",
        profileImageUrl:
            "https://t3.ftcdn.net/jpg/02/43/12/34/360_F_243123463_zTooub557xEWABDLk0jJklDyLSGl2jrr.jpg",
        id: "1234534",
        title: "Arabic teacher"),
  );
  static List<CourseEntity> TestCoursesList = [courseEntity];
}

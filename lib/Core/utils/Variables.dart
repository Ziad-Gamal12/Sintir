// ignore_for_file: non_constant_identifier_names, file_names

import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/ContentCreaterEntity.dart';
import 'package:sintir/Core/entities/CourseEntity.dart';
import 'package:sintir/Core/utils/Backend_EndPoints.dart';
import 'package:sintir/Core/utils/imageAssets.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CoursSectionsListItemEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseFileEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseTestEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseTestQuestionEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseTestQuestionSolutionEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseVedioItemEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CoursefedbackItemEntity.dart';

abstract class Variables {
  static GlobalKey<FormState> TeacherSignUpFormKey = GlobalKey<FormState>();
  static GlobalKey<FormState> StudnetSignUpFormKey = GlobalKey<FormState>();
  static GlobalKey<FormState> TeacherLoginFormKey = GlobalKey<FormState>();
  static GlobalKey<FormState> AddCourseSectionFormKey = GlobalKey<FormState>();
  static GlobalKey<FormState> TeacherResetPasswordFormKey =
      GlobalKey<FormState>();
  static GlobalKey<ScaffoldState> HomeViewScaffoldKey =
      GlobalKey<ScaffoldState>();
  static GlobalKey<ScaffoldState> DisplaycoursevedioveiwScaffoldKey =
      GlobalKey<ScaffoldState>();
  static GlobalKey<FormState> AddCourseSectionSQLtestFormKey =
      GlobalKey<FormState>();
  static TextEditingController TeacherSignUpFirstNameController =
      TextEditingController();
  static TextEditingController TeacherSignUpLastNameController =
      TextEditingController();
  static TextEditingController TeacherSignUpEmailController =
      TextEditingController();
  static TextEditingController TeacherSignUpPasswordController =
      TextEditingController();
  static TextEditingController TeacherSignUpAdressController =
      TextEditingController();
  static TextEditingController TeacherSignUpPhoneNumberController =
      TextEditingController();
  static TextEditingController TeacherSignUpSubjectController =
      TextEditingController();
  static TextEditingController TeacherSignUpWorkExperienceController =
      TextEditingController();
  static TextEditingController TeacherLoginEmailController =
      TextEditingController();
  static TextEditingController TeacherLoginPasswordController =
      TextEditingController();
  static TextEditingController StudentSigninEmailController =
      TextEditingController();
  static TextEditingController StudentSigninPasswordController =
      TextEditingController();
  static TextEditingController ResetPasswordController =
      TextEditingController();
  static TextEditingController studentSignUpEmailController =
      TextEditingController();
  static TextEditingController studentSignUpFirstNameController =
      TextEditingController();
  static TextEditingController studentSignUpLastNameController =
      TextEditingController();
  static TextEditingController studentSignUpBirthDateController =
      TextEditingController();
  static TextEditingController studentSignUpEducationLevelController =
      TextEditingController();
  static TextEditingController studentSignUpSchoolNameController =
      TextEditingController();
  static TextEditingController studentSignUpPasswordController =
      TextEditingController();
  static TextEditingController studentSignUpPhoneNumberController =
      TextEditingController();
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
      subscripersCount: 0,
      state: BackendEndpoints.coursePublishedState,
      id: "12345567",
      posterUrl:
          "https://img.freepik.com/free-psd/e-learning-online-courses-poster-template_23-2149109793.jpg",
      title: "أساسيات دمج الصور",
      description:
          "في كريتيڤز إكس بنحقق معادلة صعبة، معادلة إنك تستمتع و في نفس الوقت تستفيد .",
      price: "120",
      language: "العربيه",
      subscripersIDS: [],
      postedDate: DateTime(2024, 8, 11),
      contentcreaterentity: Contentcreaterentity(
          name: "Adel Gamal",
          profileImageUrl:
              "https://t3.ftcdn.net/jpg/02/43/12/34/360_F_243123463_zTooub557xEWABDLk0jJklDyLSGl2jrr.jpg",
          id: "1234534",
          title: "Arabic teacher"),
      coursSectionsListItemEntity: [
        CoursSectionsListItemEntity(
            title: "برومو - دورة حياة المنتج",
            items: [
              Coursevedioitementity(
                  title: "برومو - دورة حياة",
                  vedioUrl:
                      "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
                  durationTime: 130),
              Coursetestentity(questions: [
                // Coursetestentity coursetestentity = Coursetestentity(
                Coursetestquestionentity(
                    questionTitle: "ما هو العدد الذرى للعنصر Zn",
                    solutions: [
                      Coursetestquestionsolutionentity(
                          answer: "14", isCorrect: false),
                      Coursetestquestionsolutionentity(
                          answer: "13", isCorrect: false),
                      Coursetestquestionsolutionentity(
                          answer: "12", isCorrect: true),
                      Coursetestquestionsolutionentity(
                          answer: "16", isCorrect: false),
                    ],
                    isOpened: false),
                Coursetestquestionentity(
                    questionTitle: "ما هو العدد الذرى للعنصر Mg",
                    solutions: [
                      Coursetestquestionsolutionentity(
                          answer: "17", isCorrect: false),
                      Coursetestquestionsolutionentity(
                          answer: "22", isCorrect: false),
                      Coursetestquestionsolutionentity(
                          answer: "42", isCorrect: true),
                      Coursetestquestionsolutionentity(
                          answer: "18", isCorrect: false),
                    ],
                    isOpened: false)
              ], durationTime: 120, title: "امتحان شامل على المنهج"),
              Coursefileentity(
                  description: "ملخص المنهج",
                  title: "ملف تلخيص المنهج",
                  fileUrl: "assets/Files/PDFTest.pdf")
            ],
            subtitle: "عملية إطلاق المنتج"),
      ],
      coursefedbackItemEntity: [
        CoursefedbackItemEntity(
            userImage: Assets.assetsImagesUserAvatar,
            name: "Ziad Gamal",
            fedBack: "كورس رائع ماشاء الله",
            likesCount: "11",
            datePosted: DateTime(2024, 9, 13))
      ],
      courseReports: []);
  static List<CourseEntity> TestCoursesList = [courseEntity];
}

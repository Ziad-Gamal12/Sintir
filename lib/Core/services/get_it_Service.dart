// ignore_for_file: file_names, non_constant_identifier_names

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:sintir/Core/repos/AssetsPickerRepo/AssetsPickerRepo.dart';
import 'package:sintir/Core/repos/AssetsPickerRepo/AssetsPickerRepoImpli.dart';
import 'package:sintir/Core/repos/CourseFeedBacksRepo/CourseFeedBacksRepo.dart';
import 'package:sintir/Core/repos/CourseFeedBacksRepo/CourseFeedBacksRepoImpli.dart';
import 'package:sintir/Core/repos/CourseReportsRepo/CourseReportsRepo.dart';
import 'package:sintir/Core/repos/CourseReportsRepo/CourseReportsRepoImpli.dart';
import 'package:sintir/Core/repos/CourseSectionsRepos/CourseSectionsRepo.dart';
import 'package:sintir/Core/repos/CourseSectionsRepos/CourseSectionsRepo_impl.dart';
import 'package:sintir/Core/repos/CourseSubscibtionsRepo/CourseSubscibtionsRepo.dart';
import 'package:sintir/Core/repos/CourseSubscibtionsRepo/CourseSubscibtionsRepo_impli.dart';
import 'package:sintir/Core/repos/CoursesRepo/CoursesRepo.dart';
import 'package:sintir/Core/repos/CoursesRepo/CoursesRepo_impl.dart';
import 'package:sintir/Core/repos/File-Item-Repo/FileItemRepo.dart';
import 'package:sintir/Core/repos/File-Item-Repo/FileItemRepoImpli.dart';
import 'package:sintir/Core/repos/PaymobRepo.dart/PaymobRepo.dart';
import 'package:sintir/Core/repos/PaymobRepo.dart/PaymobRepoImp.dart';
import 'package:sintir/Core/repos/ResetPaswordRepo/ResetPaswordRepo.dart';
import 'package:sintir/Core/repos/ResetPaswordRepo/ResetPaswordRepoImp.dart';
import 'package:sintir/Core/repos/SectionItemsActionsRepo/SectionItemsActionRepo.dart';
import 'package:sintir/Core/repos/SectionItemsActionsRepo/SectionItemsActionRepoImpli.dart';
import 'package:sintir/Core/repos/Test-Item-Repo/TestItemRepo-Impli.dart';
import 'package:sintir/Core/repos/Test-Item-Repo/TestItemRepo.dart';
import 'package:sintir/Core/repos/Video-Item-Repo/VideoItemRepo.dart';
import 'package:sintir/Core/repos/Video-Item-Repo/VideoItemRepoImpli.dart';
import 'package:sintir/Core/services/DataBaseService.dart';
import 'package:sintir/Core/services/FirebaseAuth_Service.dart';
import 'package:sintir/Core/services/FirebaseStorageService.dart';
import 'package:sintir/Core/services/Firebase_FirestoreService.dart';
import 'package:sintir/Core/services/GeminiAPiService.dart';
import 'package:sintir/Core/services/PayMobService.dart';
import 'package:sintir/Core/services/PickerAssetsService.dart';
import 'package:sintir/Core/services/StorageService.dart';
import 'package:sintir/Core/services/elevenlabsApi.dart';
import 'package:sintir/Core/services/sqfliteServices.dart';
import 'package:sintir/Features/Ai_Teacher/data/repos_impli/AiTeacherRepo_Impli.dart';
import 'package:sintir/Features/Ai_Teacher/domain/Repos/AITeacherRepo.dart';
import 'package:sintir/Features/Auth/Data/repos/AuthRepoImpl.dart';
import 'package:sintir/Features/Auth/Domain/Repos/AuthRepo.dart';

final getIt = GetIt.instance;

void setup_Getit() {
  getIt.registerSingleton<firebaseAuthService>(firebaseAuthService());
  getIt.registerSingleton<firebasestorageservice>(
      firebasestorageservice(pickerassetsservice: Pickerassetsservice()));
  getIt.registerSingleton<StorageService>(getIt<firebasestorageservice>());
  getIt.registerSingleton<Dio>(Dio());
  getIt.registerSingleton<Databaseservice>(FirebaseFirestoreservice());
  getIt.registerSingleton<Sqfliteservices>(Sqfliteservices());
  getIt.registerSingleton<Coursesrepo>(CoursesrepoImpl(
      databaseservice: getIt<Databaseservice>(),
      storageService: getIt<StorageService>()));
  getIt.registerSingleton<Pickerassetsservice>(Pickerassetsservice());
  getIt.registerSingleton<ResetPaswordRepo>(
      ResetPaswordRepoImp(authService: firebaseAuthService()));
  getIt.registerSingleton<AuthRepo>(AuthRepoImpl(
      databaseservice: getIt<Databaseservice>(),
      authService: getIt<firebaseAuthService>()));
  getIt.registerSingleton<CourseSectionsRepo>(CourseSectionsRepoImpl(
    datebaseservice: getIt<Databaseservice>(),
  ));
  getIt.registerSingleton<Assetspickerrepo>(
      Assetspickerrepoimpli(pickerassetsservice: getIt<Pickerassetsservice>()));
  getIt.registerSingleton<CourseSubscibtionsRepo>(
      CourseSubscriptionsRepoImpl(databaseService: getIt<Databaseservice>()));

  getIt.registerSingleton<Testitemrepo>(Testitemrepoimpli(
      storageService: getIt<StorageService>(),
      datebaseservice: getIt<Databaseservice>()));
  getIt.registerSingleton<SectionItemsActionsRepo>(
      SectionItemsActionsRepoImpli(datebaseservice: getIt<Databaseservice>()));
  getIt.registerSingleton<VideoItemRepo>(VideoItemRepoImpli(
    storageService: getIt<StorageService>(),
    databaseservice: getIt<Databaseservice>(),
  ));
  getIt.registerSingleton<FileItemRepo>(FileItemRepoImpli(
    storageService: getIt<StorageService>(),
  ));
  getIt.registerSingleton<AiTeacherRepo>(AiTeacherRepoImpli(
    pickerassetsservice: getIt<Pickerassetsservice>(),
    geminiApiService: GeminiApiService(dio: getIt<Dio>()),
    elevenlabsApi: ElevenlabsApi(dio: getIt<Dio>()),
  ));
  getIt.registerSingleton<CourseReportsRepo>(
      CourseReportsRepoimpli(databaseservice: getIt<Databaseservice>()));
  getIt.registerSingleton<CourseFeedBacksRepo>(
      CourseFeedBacksRepoImpli(databaseservice: getIt<Databaseservice>()));
  getIt.registerSingleton<PaymobRepo>(
      PaymobRepoImp(payMobService: PayMobService()));
}

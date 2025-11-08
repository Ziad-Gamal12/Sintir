// ignore_for_file: file_names, non_constant_identifier_names

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:sintir/Core/repos/AssetsPickerRepo/AssetsPickerRepo.dart';
import 'package:sintir/Core/repos/AssetsPickerRepo/AssetsPickerRepoImpli.dart';
import 'package:sintir/Core/repos/CourseCouponsRepo/CourseCouponsRepo.dart';
import 'package:sintir/Core/repos/CourseCouponsRepo/CourseCouponsRepoImp.dart';
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
import 'package:sintir/Core/repos/PaymobPayoutRepo/PaymobPayoutRepo.dart';
import 'package:sintir/Core/repos/PaymobPayoutRepo/PaymobPayoutRepoImpl.dart';
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
import 'package:sintir/Core/services/FireBase/FirebaseAuth_Service.dart';
import 'package:sintir/Core/services/FireBase/Firebase_FirestoreService.dart';
import 'package:sintir/Core/services/FireBase/firebaseStorageService.dart';
import 'package:sintir/Core/services/GeminiAPiService.dart';
import 'package:sintir/Core/services/Paymob/PayMobService.dart';
import 'package:sintir/Core/services/Paymob/PaymobPayoutService.dart';
import 'package:sintir/Core/services/PickerAssetsService.dart';
import 'package:sintir/Core/services/StorageService.dart';
import 'package:sintir/Core/services/elevenlabsApi.dart';
import 'package:sintir/Features/Ai_Teacher/data/repos_impli/AiTeacherRepo_Impli.dart';
import 'package:sintir/Features/Ai_Teacher/domain/Repos/AITeacherRepo.dart';
import 'package:sintir/Features/Auth/Data/repos/AuthRepoImpl.dart';
import 'package:sintir/Features/Auth/Domain/Repos/AuthRepo.dart';
import 'package:sintir/Features/ContentCreatorProfile/data/Repos/ContentCreatorProfileRepoImpl.dart';
import 'package:sintir/Features/ContentCreatorProfile/domain/Repos/ContentCreatorProfileRepo.dart';
import 'package:sintir/Features/MyMistakes/Data/Repos/MyMistakesRepoImpl.dart';
import 'package:sintir/Features/MyMistakes/Domain/Repo/MyMistakesRepo.dart';
import 'package:sintir/Features/MyResults/Data/Repo/MyResultsRepoImpl.dart';
import 'package:sintir/Features/MyResults/Domain/Repo/MyResultsRepo.dart';
import 'package:sintir/Features/Search/Data/Repos/SearchRepoImpl.dart';
import 'package:sintir/Features/Search/Domain/Repos/SearchRepo.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/data/Repos/TeacherWalletRepoImpl.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Repos/TeacherWalletRepo.dart';

final getIt = GetIt.instance;

void setup_Getit() {
  getIt.registerLazySingleton<Dio>(() => Dio());
  getIt.registerLazySingleton<firebaseAuthService>(() => firebaseAuthService());
  getIt.registerLazySingleton<Pickerassetsservice>(() => Pickerassetsservice());
  getIt
      .registerLazySingleton<DataBaseService>(() => FirebaseFirestoreservice());
  getIt.registerLazySingleton<firebasestorageservice>(
      () => firebasestorageservice(pickerassetsservice: getIt()));
  getIt.registerLazySingleton<StorageService>(
      () => getIt<firebasestorageservice>());

  getIt.registerLazySingleton<Coursesrepo>(() => CoursesrepoImpl(
        databaseservice: getIt(),
        storageService: getIt(),
      ));
  getIt.registerLazySingleton<CourseSectionsRepo>(
      () => CourseSectionsRepoImpl(datebaseservice: getIt()));
  getIt.registerLazySingleton<SectionItemsActionsRepo>(
      () => SectionItemsActionsRepoImpli(datebaseservice: getIt()));
  getIt.registerLazySingleton<VideoItemRepo>(() =>
      VideoItemRepoImpli(storageService: getIt(), databaseservice: getIt()));
  getIt.registerLazySingleton<FileItemRepo>(
      () => FileItemRepoImpli(storageService: getIt()));
  getIt.registerLazySingleton<Testitemrepo>(() =>
      TestItemRepoImpli(storageService: getIt(), databaseservice: getIt()));
  getIt.registerLazySingleton<Assetspickerrepo>(
      () => Assetspickerrepoimpli(pickerassetsservice: getIt()));
  getIt.registerLazySingleton<CourseSubscibtionsRepo>(
      () => CourseSubscriptionsRepoImpl(databaseService: getIt()));
  getIt.registerLazySingleton<CourseReportsRepo>(
      () => CourseReportsRepoimpli(databaseservice: getIt()));
  getIt.registerLazySingleton<CourseFeedBacksRepo>(
      () => CourseFeedBacksRepoImpli(databaseservice: getIt()));
  getIt.registerLazySingleton<CourseCouponsRepo>(
      () => CourseCouponsRepoImp(databaseservice: getIt()));

  getIt.registerLazySingleton<PaymobRepo>(
      () => PaymobRepoImp(payMobService: PayMobService()));
  getIt.registerLazySingleton<PaymobPayoutRepo>(
      () => PaymobPayoutRepoImpl(service: PaymobPayoutService()));

  getIt.registerLazySingleton<ResetPaswordRepo>(
      () => ResetPaswordRepoImp(authService: getIt<firebaseAuthService>()));
  getIt.registerLazySingleton<AuthRepo>(() => AuthRepoImpl(
        databaseservice: getIt(),
        authService: getIt(),
      ));

  getIt.registerLazySingleton<AiTeacherRepo>(() => AiTeacherRepoImpli(
        pickerassetsservice: getIt(),
        geminiApiService: GeminiApiService(dio: getIt()),
        elevenlabsApi: ElevenlabsApi(dio: getIt()),
      ));

  getIt.registerLazySingleton<SearchRepo>(
      () => SearchRepoImpl(databaseservice: getIt()));

  getIt.registerLazySingleton<TeacherWalletRepo>(() => TeacherWalletRepoImpl(
        databaseservice: getIt<DataBaseService>(),
        authRepo: getIt<AuthRepo>(),
      ));
  getIt.registerLazySingleton<MyMistakesRepo>(
      () => MyMistakesRepoImpl(databaseservice: getIt<DataBaseService>()));
  getIt.registerLazySingleton<MyResultsRepo>(
      () => MyResultsRepoImpl(dataBaseService: getIt<DataBaseService>()));

  getIt.registerLazySingleton<ContentCreatorProfileRepo>(() =>
      ContentCreatorProfileRepoImpl(dataBaseService: getIt<DataBaseService>()));
}

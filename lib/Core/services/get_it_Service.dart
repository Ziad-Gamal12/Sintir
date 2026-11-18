// ignore_for_file: file_names, non_constant_identifier_names

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:sintir/Core/repos/AssetsPickerRepo/AssetsPickerRepo.dart';
import 'package:sintir/Core/repos/AssetsPickerRepo/AssetsPickerRepoImpli.dart';
import 'package:sintir/Core/repos/CourseCheckoutRepo/CourseCheckoutRepo.dart';
import 'package:sintir/Core/repos/CourseCheckoutRepo/CourseCheckoutRepoImpl.dart';
import 'package:sintir/Core/repos/CourseCountersRepo/CourseCountersRepo.dart';
import 'package:sintir/Core/repos/CourseCountersRepo/CourseCountersRepoImpl.dart';
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
import 'package:sintir/Core/services/Paymob/PayMobService.dart';
import 'package:sintir/Core/services/PickerAssetsService.dart';
import 'package:sintir/Core/services/RealtimeDataBaseService.dart';
import 'package:sintir/Core/services/StorageService.dart';
import 'package:sintir/Core/services/VideoUploadService.dart';
import 'package:sintir/Core/services/SupabaseStorageServices.dart';
import 'package:sintir/Core/helper/GetUserData.dart';
import 'package:sintir/Core/repos/ReviewModerationRepo/ReviewModerationRepo.dart';
import 'package:sintir/Core/repos/ReviewModerationRepo/ReviewModerationRepoImpl.dart';
import 'package:sintir/Core/services/EdgeFunctionsService.dart';
import 'package:sintir/Core/services/NetworkStatus.dart';
import 'package:sintir/Core/services/TeacherWithdrawalService.dart';
import 'package:sintir/Features/Auth/Data/repos/AuthRepoImpl.dart';
import 'package:sintir/Features/Auth/Domain/Repos/AuthRepo.dart';
import 'package:sintir/Features/ContentCreatorProfile/data/Repos/ContentCreatorProfileRepoImpl.dart';
import 'package:sintir/Features/ContentCreatorProfile/domain/Repos/ContentCreatorProfileRepo.dart';
import 'package:sintir/Features/Favorites/Data/Repos/FavoritesRepoImpl.dart';
import 'package:sintir/Features/Favorites/Domain/Repos/FavoritesRepo.dart';
import 'package:sintir/Features/MyMistakes/Data/Repos/MyMistakesRepoImpl.dart';
import 'package:sintir/Features/MyMistakes/Domain/Repo/MyMistakesRepo.dart';
import 'package:sintir/Features/MyResults/Data/Repo/my_results_repo_impl.dart';
import 'package:sintir/Features/MyResults/Domain/Repo/my_results_repo.dart';
import 'package:sintir/Features/MyTransactions/Data/Repos/MyTransactionsRepImpl.dart';
import 'package:sintir/Features/MyTransactions/Domain/Repos/MyTransactionsRep.dart';
import 'package:sintir/Features/Profile/Data/Repos/AccountDeletionRepoImpl.dart';
import 'package:sintir/Features/Profile/Data/Repos/PersonalDetailsRepoImpl.dart';
import 'package:sintir/Features/Profile/Domain/Repos/AccountDeletionRepo.dart';
import 'package:sintir/Features/Profile/Domain/Repos/PersonalDetailsRepo.dart';
import 'package:sintir/Features/Search/Data/Repos/SearchRepoImpl.dart';
import 'package:sintir/Features/Search/Domain/Repos/SearchRepo.dart';
import 'package:sintir/Features/Support/Data/Repos/SupportChatRepoImpl.dart';
import 'package:sintir/Features/Support/Data/Repos/SupportTicketsRepoImpl.dart';
import 'package:sintir/Features/Support/Domain/Repos/SupportChatRepo.dart';
import 'package:sintir/Features/Support/Domain/Repos/SupportTicketsRepo.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/data/Repos/SubscribersDetailsRepoImpl.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/data/Repos/TeacherCourseReviewsRepoImpl.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Repos/TeacherCourseReviewsRepo.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/data/Repos/TeacherWorkspaceRepoImpl.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Repos/TeacherWorkspaceRepo.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/data/Repos/TeacherLiveWalletRepoImpl.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Repos/TeacherLiveWalletRepo.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/data/Repos/WithDrawalTeacherBalanceRepoImpl.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Repos/SubscribersDetailsRepo.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Repos/WithDrawalTeacherBalanceRepo.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/domain/UseCases/UpdateCourseReportStatusUseCase.dart';
import 'package:sintir/Core/services/Shared_preferences.dart';
import 'package:sintir/constant.dart';

final getIt = GetIt.instance;

void setup_Getit() {
  getIt.registerLazySingleton<Dio>(() => Dio());
  getIt.registerLazySingleton<ConnectivityService>(() => ConnectivityService());
  getIt.registerLazySingleton<PickerAssetsService>(() => PickerAssetsService());

  // to ensure they are available immediately for auto-login logic.
  getIt.registerLazySingleton<firebaseAuthService>(() => firebaseAuthService());
  // One Firestore service instance serves both one-shot and live reads.
  getIt.registerLazySingleton<FirebaseFirestoreservice>(
    () => FirebaseFirestoreservice(),
  );
  getIt.registerLazySingleton<DataBaseService>(
    () => getIt<FirebaseFirestoreservice>(),
  );
  getIt.registerLazySingleton<RealtimeDataBaseService>(
    () => getIt<FirebaseFirestoreservice>(),
  );
  getIt.registerLazySingleton<SupabaseStorageServices>(
    () => SupabaseStorageServices(edgeFunctions: getIt<EdgeFunctionsService>()),
  );
  getIt.registerLazySingleton<StorageService>(
    () => getIt<SupabaseStorageServices>(),
  );
  getIt.registerLazySingleton<CourseCountersRepo>(
    () => CourseCountersRepoImpl(databaseservice: getIt<DataBaseService>()),
  );
  getIt.registerLazySingleton<PaymobRepo>(
    () => PaymobRepoImp(payMobService: PayMobService()),
  );

  getIt.registerLazySingleton<ResetPaswordRepo>(
    () => ResetPaswordRepoImp(authService: getIt<firebaseAuthService>()),
  );

  getIt.registerLazySingleton<AuthRepo>(
    () => AuthRepoImpl(
      databaseservice: getIt<DataBaseService>(),
      authService: getIt(),
    ),
  );

  getIt.registerLazySingleton<Coursesrepo>(
    () => CoursesrepoImpl(
      databaseservice: getIt<DataBaseService>(),
      storageService: getIt(),
    ),
  );

  getIt.registerLazySingleton<CourseSectionsRepo>(
    () => CourseSectionsRepoImpl(
      datebaseservice: getIt<DataBaseService>(),
      courseCountersRepo: getIt<CourseCountersRepo>(),
    ),
  );

  getIt.registerLazySingleton<SectionItemsActionsRepo>(
    () => SectionItemsActionsRepoImpli(
      datebaseservice: getIt<DataBaseService>(),
      courseCountersRepo: getIt<CourseCountersRepo>(),
    ),
  );

  getIt.registerLazySingleton<VideoUploadService>(
    () => VideoUploadService(dio: getIt<Dio>()),
  );
  getIt.registerLazySingleton<VideoItemRepo>(
    () => VideoItemRepoImpli(
      videoUploadService: getIt<VideoUploadService>(),
      databaseservice: getIt<DataBaseService>(),
    ),
  );

  getIt.registerLazySingleton<FileItemRepo>(
    () => FileItemRepoImpli(
      storageService: getIt(),
      edgeFunctions: getIt<EdgeFunctionsService>(),
    ),
  );

  getIt.registerLazySingleton<Testitemrepo>(
    () => TestItemRepoImpli(
      storageService: getIt(),
      databaseservice: getIt<DataBaseService>(),
      myResultsRepo: getIt<MyResultsRepo>(),
      edgeFunctions: getIt<EdgeFunctionsService>(),
    ),
  );

  getIt.registerLazySingleton<Assetspickerrepo>(
    () => Assetspickerrepoimpli(pickerassetsservice: getIt()),
  );

  getIt.registerLazySingleton<CourseCheckoutGateway>(
    () => CourseCheckoutRepoImpl(),
  );
  getIt.registerLazySingleton<CourseSubscibtionsRepo>(
    () => CourseSubscriptionsRepoImpl(
      databaseService: getIt<DataBaseService>(),
      checkoutGateway: getIt<CourseCheckoutGateway>(),
    ),
  );

  getIt.registerLazySingleton<CourseReportsRepo>(
    () => CourseReportsRepoimpli(),
  );
  getIt.registerLazySingleton<UpdateCourseReportStatusUseCase>(
    () => UpdateCourseReportStatusUseCase(getIt<CourseReportsRepo>()),
  );

  getIt.registerLazySingleton<EdgeFunctionsService>(
    () => EdgeFunctionsService(),
  );
  getIt.registerLazySingleton<CourseFeedBacksRepo>(
    () => CourseFeedBacksRepoImpli(
      databaseservice: getIt<DataBaseService>(),
      edgeFunctions: getIt<EdgeFunctionsService>(),
    ),
  );

  getIt.registerLazySingleton<TeacherCourseReviewsRepo>(
    () => TeacherCourseReviewsRepoImpl(
      databaseservice: getIt<DataBaseService>(),
      feedBacksRepo: getIt<CourseFeedBacksRepo>(),
      preferences: shared_preferences_Services.sharedPreferences,
    ),
  );

  getIt.registerLazySingleton<TeacherWorkspaceRepo>(
    () => TeacherWorkspaceRepoImpl(
      preferences: shared_preferences_Services.sharedPreferences,
      reviewsRepo: getIt<TeacherCourseReviewsRepo>(),
    ),
  );

  getIt.registerLazySingleton<CourseCouponsRepo>(
    () => CourseCouponsRepoImp(databaseservice: getIt<DataBaseService>()),
  );

  getIt.registerLazySingleton<SearchRepo>(
    () => SearchRepoImpl(databaseservice: getIt<DataBaseService>()),
  );

  getIt.registerLazySingleton<MyMistakesRepo>(
    () => MyMistakesRepoImpl(
      databaseservice: getIt<DataBaseService>(),
      myResultsRepo: getIt<MyResultsRepo>(),
    ),
  );

  getIt.registerLazySingleton<MyResultsRepo>(
    () => MyResultsRepoImpl(dataBaseService: getIt<DataBaseService>()),
  );

  getIt.registerLazySingleton<ContentCreatorProfileRepo>(
    () => ContentCreatorProfileRepoImpl(
      dataBaseService: getIt<DataBaseService>(),
    ),
  );

  getIt.registerLazySingleton<SubscribersDetailsRepo>(
    () => SubscribersDetailsRepoImpl(databaseservice: getIt<DataBaseService>()),
  );

  getIt.registerLazySingleton<FavoritesRepo>(
    () => FavoritesRepoImpl(dataBaseService: getIt<DataBaseService>()),
  );

  getIt.registerLazySingleton<ReviewModerationRepo>(
    () => ReviewModerationRepoImpl(
      databaseservice: getIt<DataBaseService>(),
      currentUserId: () => getUserData().uid,
      currentUserRole: () => getUserData().role,
    ),
  );
  getIt.registerLazySingleton<AccountDeletionRepo>(() {
    final auth = getIt<firebaseAuthService>();
    return AccountDeletionRepoImpl(
      edgeFunctions: getIt<EdgeFunctionsService>(),
      reauthenticate: auth.reauthenticate,
      signInProvider: auth.primarySignInProvider,
      clearLocalSession: auth.clearLocalSession,
    );
  });
  getIt.registerLazySingleton<PersonalDetailsRepo>(
    () => PersonalDetailsRepoImpl(
      dataBaseService: getIt<DataBaseService>(),
      storageService: getIt(),
      authRepo: getIt(),
      assetspickerrepo: getIt(),
    ),
  );

  getIt.registerLazySingleton<MyTransactionsRepo>(
    () => MyTransactionsRepoImpl(dataBaseService: getIt<DataBaseService>()),
  );

  getIt.registerLazySingleton<SupportTicketsRepo>(
    () => SupportTicketsRepoImpl(dataBaseService: getIt<DataBaseService>()),
  );

  getIt.registerLazySingleton<SupportChatRepo>(
    () => SupportChatRepoImpl(
      dataBaseService: getIt(),
      pickerassetsservice: getIt(),
      storageService: getIt(),
    ),
  );
  getIt.registerLazySingleton<TeacherWithdrawalService>(
    () => TeacherWithdrawalService(
      dio: getIt<Dio>(),
      url: supaBaseUrl,
      publishableKey: supaAnonKey,
    ),
  );
  getIt.registerLazySingleton<WithDrawalTeacherBalanceRepo>(
    () => WithDrawalTeacherBalanceRepoImpl(
      service: getIt<TeacherWithdrawalService>(),
    ),
  );
  getIt.registerLazySingleton<TeacherLiveWalletRepo>(
    () => TeacherLiveWalletRepoImpl(
      realtimeDataBaseService: getIt<RealtimeDataBaseService>(),
    ),
  );
}

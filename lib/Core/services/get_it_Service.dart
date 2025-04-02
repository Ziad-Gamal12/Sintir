// ignore_for_file: file_names, non_constant_identifier_names

import 'package:get_it/get_it.dart';
import 'package:sintir/Core/repos/AssetsPickerRepo/AssetsPickerRepo.dart';
import 'package:sintir/Core/repos/AssetsPickerRepo/AssetsPickerRepoImpli.dart';
import 'package:sintir/Core/repos/CoursesRepo/CoursesRepo.dart';
import 'package:sintir/Core/repos/CoursesRepo/CoursesRepo_impl.dart';
import 'package:sintir/Core/repos/PaymentRepo/paymentRepo.dart';
import 'package:sintir/Core/repos/PaymentRepo/paymentRepo_impli.dart';
import 'package:sintir/Core/repos/UserRepos/UserRepoImpli.dart';
import 'package:sintir/Core/repos/UserRepos/userRepo.dart';
import 'package:sintir/Core/repos/authRepos/authRepo_impli.dart';
import 'package:sintir/Core/repos/authRepos/authrepo.dart';
import 'package:sintir/Core/services/DateBaseService.dart';
import 'package:sintir/Core/services/FirebaseAuth_Service.dart';
import 'package:sintir/Core/services/FirebaseStorageService.dart';
import 'package:sintir/Core/services/Firebase_FirestoreService.dart';
import 'package:sintir/Core/services/PayMobService.dart';
import 'package:sintir/Core/services/PickerAssetsService.dart';
import 'package:sintir/Core/services/StorageService.dart';
import 'package:sintir/Core/services/sqfliteServices.dart';
import 'package:sintir/Features/StudenetAuth/data/repoos/studentAuth_repo_impli.dart';
import 'package:sintir/Features/StudenetAuth/domain/repos/studentAuth_repo.dart';
import 'package:sintir/Features/TeacherAuth/Data/Repos_Impli/teacherAuthRepos_Impli.dart';
import 'package:sintir/Features/TeacherAuth/Domain/Repos/repos.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/data/Repos_impl/AddCourseSectionRepo_impl.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/repos/AddCourseSectionRepo.dart';

final getIt = GetIt.instance;

void setup_Getit() {
  getIt.registerSingleton<firebaseAuthService>(firebaseAuthService());
  getIt.registerSingleton<firebasestorageservice>(
      firebasestorageservice(pickerassetsservice: Pickerassetsservice()));
  getIt.registerSingleton<StorageService>(getIt<firebasestorageservice>());

  getIt.registerSingleton<Datebaseservice>(FirebaseFirestoreservice());
  getIt.registerSingleton<Sqfliteservices>(Sqfliteservices());
  getIt.registerSingleton<Coursesrepo>(CoursesrepoImpl(
      datebaseservice: getIt<Datebaseservice>(),
      storageService: getIt<StorageService>()));
  getIt.registerSingleton<Pickerassetsservice>(Pickerassetsservice());
  getIt.registerSingleton<StudentauthRepo>(StudentauthRepoImpli(
      firebaseAuth: getIt<firebaseAuthService>(),
      datebaseservice: getIt<Datebaseservice>()));
  getIt.registerSingleton<Authrepo>(
      AuthrepoImpli(authService: firebaseAuthService()));
  getIt.registerSingleton<TeacherAuthRepos>(teacherAuthRepos_Impli(
      dataBaseService: getIt<Datebaseservice>(),
      authService: getIt<firebaseAuthService>(),
      storageService: getIt<StorageService>()));
  getIt.registerSingleton<Userrepo>(
      Userrepoimpli(datebaseservicel: getIt<Datebaseservice>()));
  getIt.registerSingleton<Addcoursesectionrepo>(AddcoursesectionrepoImpl(
      storageService: getIt<StorageService>(),
      datebaseservice: getIt<Datebaseservice>(),
      pickerassetsservice: getIt<Pickerassetsservice>()));
  getIt.registerSingleton<Assetspickerrepo>(
      Assetspickerrepoimpli(pickerassetsservice: getIt<Pickerassetsservice>()));
  getIt.registerSingleton<Paymentrepo>(
      PaymentrepoImpli(payMobService: PayMobService()));
}

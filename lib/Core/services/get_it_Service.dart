// ignore_for_file: file_names, non_constant_identifier_names

import 'package:get_it/get_it.dart';
import 'package:sintir/Core/services/DateBaseService.dart';
import 'package:sintir/Core/services/FirebaseAuth_Service.dart';
import 'package:sintir/Core/services/FirebaseStorageService.dart';
import 'package:sintir/Core/services/Firebase_FirestoreService.dart';
import 'package:sintir/Core/services/PickerAssetsService.dart';
import 'package:sintir/Features/TeacherAuth/Data/Repos_Impli/teacherAuthRepos_Impli.dart';
import 'package:sintir/Features/TeacherAuth/Domain/Repos/repos.dart';

final getIt = GetIt.instance;

void setup_Getit() {
  getIt.registerSingleton<firebaseAuthService>(firebaseAuthService());
  getIt.registerSingleton<firebasestorageservice>(
      firebasestorageservice(pickerassetsservice: Pickerassetsservice()));
  getIt.registerSingleton<Datebaseservice>(FirebaseFirestoreservice());

  getIt.registerSingleton<TeacherAuthRepos>(teacherAuthRepos_Impli(
      dataBaseService: getIt<Datebaseservice>(),
      authService: getIt<firebaseAuthService>(),
      firebaseStorageService: getIt<firebasestorageservice>()));
}

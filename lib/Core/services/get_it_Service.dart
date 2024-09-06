import 'package:fruits/core/services/FirebaseAuth_Service.dart';
import 'package:fruits/core/services/Firebase_FirestoreService.dart';
import 'package:fruits/features/Auth/data/Repos/AuthRepo_impl.dart';
import 'package:fruits/features/Auth/domain/Repos/AuthRepo.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setup_Getit() {
  getIt.registerSingleton<firebaseAuthService>(firebaseAuthService());
  getIt.registerSingleton<FirebaseFirestoreservice>(FirebaseFirestoreservice());
  getIt.registerSingleton<AuthRepo>(AuthRepo_impl(
      authService: getIt<firebaseAuthService>(),
      datebaseservice: getIt<FirebaseFirestoreservice>()));
}

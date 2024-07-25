import 'package:get_it/get_it.dart';
import 'package:sintir/Core/services/FirebaseAuth_Service.dart';

final getIt = GetIt.instance;

void setup_Getit() {
  getIt.registerSingleton<firebaseAuthService>(firebaseAuthService());
}

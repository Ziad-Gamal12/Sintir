// ignore_for_file: file_names

import 'package:sintir/Core/repos/ResetPaswordRepo/ResetPaswordRepo.dart';
import 'package:sintir/Core/services/FirebaseAuth_Service.dart';

class ResetPaswordRepoImp implements ResetPaswordRepo {
  final firebaseAuthService authService;
  ResetPaswordRepoImp({required this.authService});
  @override
  Future<void> resetPassword({required String email}) async {
    await authService.resetPassword(email: email);
  }
}

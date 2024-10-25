// ignore_for_file: file_names

import 'package:sintir/Core/repos/authRepos/authrepo.dart';
import 'package:sintir/Core/services/FirebaseAuth_Service.dart';

class AuthrepoImpli implements Authrepo {
  final firebaseAuthService authService;
  AuthrepoImpli({required this.authService});
  @override
  Future<void> resetPassword({required String email}) async {
    await authService.resetPassword(email: email);
  }
}

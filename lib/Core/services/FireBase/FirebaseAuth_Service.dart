// ignore_for_file: file_names, camel_case_types, depend_on_referenced_packages

import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:math' as math;

import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sintir/Core/errors/Exceptioons.dart';
import 'package:sintir/Core/services/HiveService.dart';
import 'package:sintir/Core/utils/Backend_EndPoints.dart';
import 'package:sintir/locale_keys.dart';

class firebaseAuthService {
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<User> createUserWithEmailAndPassword(
    String email,
    String password,
    String name,
  ) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await credential.user!.updateDisplayName(name);
      await auth.currentUser!.reload();
      return auth.currentUser!;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'weak-password':
          throw CustomException(message: LocaleKeys.weakPassword);
        case 'email-already-in-use':
        case 'account-exists-with-different-credential':
          throw CustomException(message: LocaleKeys.emailInUse);
        case "network-request-failed":
          throw CustomException(message: LocaleKeys.noInternet);
        case "operation-not-allowed":
          throw CustomException(message: LocaleKeys.operationNotAllowed);
        case "too-many-requests":
          throw CustomException(message: LocaleKeys.tooManyRequests);
        case "internal-error":
          throw CustomException(message: LocaleKeys.internalError);
        default:
          throw CustomException(message: LocaleKeys.errorOccurredMessage);
      }
    } catch (e) {
      throw CustomException(message: LocaleKeys.errorOccurredMessage);
    }
  }

  Future<User> signInWithEmailAndPassword(String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user!;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          throw CustomException(message: LocaleKeys.dataNotFound);
        case 'wrong-password':
        case "invalid-credential":
          throw CustomException(message: LocaleKeys.errorInvalidEmail);
        case "too-many-requests":
          throw CustomException(message: LocaleKeys.tooManyRequests);
        case 'network-request-failed':
          throw CustomException(message: LocaleKeys.noInternet);
        case "internal-error":
          throw CustomException(message: LocaleKeys.internalError);
        case "account-exists-with-different-credential":
          throw CustomException(message: LocaleKeys.differentCredential);
        case "operation-not-allowed":
          throw CustomException(message: LocaleKeys.operationNotAllowed);
        case "user-disabled":
          throw CustomException(message: LocaleKeys.userDisabled);
        default:
          throw CustomException(message: LocaleKeys.errorOccurredMessage);
      }
    } catch (e) {
      throw CustomException(message: LocaleKeys.errorOccurredMessage);
    }
  }

  Future<User> signinWithGoogle() async {
    try {
      final GoogleSignInAccount account = await GoogleSignIn.instance
          .authenticate();

      final String? idToken = account.authentication.idToken;
      if (idToken == null) {
        throw CustomException(message: LocaleKeys.errorOccurredMessage);
      }

      final OAuthCredential credential = GoogleAuthProvider.credential(
        idToken: idToken,
      );

      final UserCredential userCredential = await FirebaseAuth.instance
          .signInWithCredential(credential);

      final User? user = userCredential.user;
      if (user == null) {
        throw CustomException(message: LocaleKeys.errorOccurredMessage);
      }
      return user;
    } on CustomException {
      rethrow;
    } on GoogleSignInException {
      throw CustomException(message: LocaleKeys.errorOccurredMessage);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'network-request-failed':
          throw CustomException(message: LocaleKeys.noInternet);
        case 'operation-not-allowed':
          throw CustomException(message: LocaleKeys.operationNotAllowed);
        case 'too-many-requests':
          throw CustomException(message: LocaleKeys.tooManyRequests);
        case 'internal-error':
          throw CustomException(message: LocaleKeys.internalError);
        case 'popup-blocked':
        case 'popup-closed-by-user':
          throw CustomException(message: LocaleKeys.popupBlocked);
        case 'account-exists-with-different-credential':
          throw CustomException(message: LocaleKeys.differentCredential);
        case 'user-disabled':
          throw CustomException(message: LocaleKeys.userDisabled);
        default:
          throw CustomException(message: LocaleKeys.errorOccurredMessage);
      }
    } catch (e) {
      throw CustomException(message: LocaleKeys.errorOccurredMessage);
    }
  }

  Future<User> signinWithFacebook() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();
      if (result.status == LoginStatus.success) {
        final OAuthCredential credential = FacebookAuthProvider.credential(
          result.accessToken!.tokenString,
        );
        final userCredential = await FirebaseAuth.instance.signInWithCredential(
          credential,
        );
        if (userCredential.user != null) {
          return userCredential.user!;
        } else {
          throw CustomException(message: LocaleKeys.dataNotFound);
        }
      } else {
        throw CustomException(message: LocaleKeys.errorOccurredMessage);
      }
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "network-request-failed":
          throw CustomException(message: LocaleKeys.noInternet);
        case "operation-not-allowed":
          throw CustomException(message: LocaleKeys.operationNotAllowed);
        case "too-many-requests":
          throw CustomException(message: LocaleKeys.tooManyRequests);
        case "internal-error":
          throw CustomException(message: LocaleKeys.internalError);
        case "popup-blocked":
        case "popup-closed-by-user":
          throw CustomException(message: LocaleKeys.popupBlocked);
        case "account-exists-with-different-credential":
          throw CustomException(message: LocaleKeys.differentCredential);
        case "user-disabled":
          throw CustomException(message: LocaleKeys.userDisabled);
        default:
          throw CustomException(message: LocaleKeys.errorOccurredMessage);
      }
    } catch (e) {
      throw CustomException(message: LocaleKeys.errorOccurredMessage);
    }
  }

  String generateNonce([int length = 32]) {
    const charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = math.Random.secure();
    return List.generate(
      length,
      (_) => charset[random.nextInt(charset.length)],
    ).join();
  }

  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<void> deleteUSer() async {
    await auth.currentUser!.delete();
  }

  static const String passwordProvider = 'password';
  static const String googleProvider = 'google.com';
  static const String facebookProvider = 'facebook.com';

  String? primarySignInProvider() {
    final user = auth.currentUser;
    if (user == null) return null;
    return primaryProviderOf(
      user.providerData.map((info) => info.providerId).toList(),
    );
  }

  static String? primaryProviderOf(List<String> providerIds) {
    for (final id in [passwordProvider, googleProvider, facebookProvider]) {
      if (providerIds.contains(id)) return id;
    }
    return providerIds.isEmpty ? null : providerIds.first;
  }

  Future<void> reauthenticate({String? password}) async {
    final user = auth.currentUser;
    if (user == null) {
      throw CustomException(message: LocaleKeys.accountDeleteSignInAgain);
    }
    try {
      final provider = primarySignInProvider();
      final AuthCredential credential;
      if (provider == passwordProvider) {
        final email = user.email;
        if (password == null || password.isEmpty || email == null) {
          throw CustomException(
            message: LocaleKeys.accountDeletePasswordRequired,
          );
        }
        credential = EmailAuthProvider.credential(
          email: email,
          password: password,
        );
      } else if (provider == googleProvider) {
        final account = await GoogleSignIn.instance.authenticate();
        final idToken = account.authentication.idToken;
        if (idToken == null) {
          throw CustomException(message: LocaleKeys.errorOccurredMessage);
        }
        credential = GoogleAuthProvider.credential(idToken: idToken);
      } else if (provider == facebookProvider) {
        final result = await FacebookAuth.instance.login();
        final token = result.accessToken;
        if (result.status != LoginStatus.success || token == null) {
          throw CustomException(message: LocaleKeys.accountReauthCancelled);
        }
        credential = FacebookAuthProvider.credential(token.tokenString);
      } else {
        throw CustomException(message: LocaleKeys.errorOccurredMessage);
      }
      await user.reauthenticateWithCredential(credential);
      await user.getIdToken(true);
    } on CustomException {
      rethrow;
    } on GoogleSignInException {
      throw CustomException(message: LocaleKeys.accountReauthCancelled);
    } on FirebaseAuthException catch (e) {
      throw CustomException(message: reauthErrorMessage(e.code));
    } catch (_) {
      throw CustomException(message: LocaleKeys.errorOccurredMessage);
    }
  }

  static String reauthErrorMessage(String code) {
    switch (code) {
      case 'wrong-password':
      case 'invalid-credential':
      case 'invalid-login-credentials':
        return LocaleKeys.wrongPassword;
      case 'user-mismatch':
        return LocaleKeys.accountReauthWrongAccount;
      case 'network-request-failed':
        return LocaleKeys.noInternet;
      case 'too-many-requests':
        return LocaleKeys.tooManyRequests;
      case 'user-disabled':
        return LocaleKeys.userDisabled;
      default:
        return LocaleKeys.errorOccurredMessage;
    }
  }

  Future<void> clearLocalSession() async {
    try {
      await GoogleSignIn.instance.signOut();
    } catch (_) {}
    try {
      await FacebookAuth.instance.logOut();
    } catch (_) {}
    try {
      await signout();
    } catch (_) {}
  }

  Future<void> signout() async {
    try {
      await auth.signOut();
    } finally {
      await Hive_Services.delete(key: BackendEndpoints.storeUserLocaly);
    }
  }

  Future<bool> isLoggedIn() async {
    return auth.currentUser != null;
  }

  Future<void> resetPassword({required String email}) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          throw CustomException(message: LocaleKeys.dataNotFound);
        case "network-request-failed":
          throw CustomException(message: LocaleKeys.noInternet);
        case "internal-error":
          throw CustomException(message: LocaleKeys.internalError);
        case "user-disabled":
          throw CustomException(message: LocaleKeys.userDisabled);
        case "too-many-requests":
          throw CustomException(message: LocaleKeys.tooManyRequests);
        case "invalid-email":
          throw CustomException(message: LocaleKeys.errorInvalidEmail);
        default:
          throw CustomException(message: LocaleKeys.errorOccurredMessage);
      }
    }
  }

  Future<bool> checkAccountPassword({required String password}) async {
    try {
      final user = auth.currentUser;
      if (user == null) return false;

      AuthCredential credential = EmailAuthProvider.credential(
        email: user.email!,
        password: password,
      );

      await user.reauthenticateWithCredential(credential);
      return true;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "network-request-failed":
          throw CustomException(message: LocaleKeys.noInternet);
        case "operation-not-allowed":
          throw CustomException(message: LocaleKeys.operationNotAllowed);
        case "too-many-requests":
          throw CustomException(message: LocaleKeys.tooManyRequests);
        case "invalid-credential":
          throw CustomException(message: LocaleKeys.errorInvalidEmail);
        case "internal-error":
          throw CustomException(message: LocaleKeys.internalError);
        case "popup-blocked":
        case "popup-closed-by-user":
          throw CustomException(message: LocaleKeys.popupBlocked);
        case "account-exists-with-different-credential":
          throw CustomException(message: LocaleKeys.differentCredential);
        case "user-disabled":
          throw CustomException(message: LocaleKeys.userDisabled);
        default:
          throw CustomException(message: LocaleKeys.errorOccurredMessage);
      }
    }
  }

  Future<void> changePassword({required String password}) async {
    try {
      final user = auth.currentUser;
      if (user == null) return;
      await user.updatePassword(password);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "network-request-failed":
          throw CustomException(message: LocaleKeys.noInternet);
        case "operation-not-allowed":
          throw CustomException(message: LocaleKeys.operationNotAllowed);
        case "too-many-requests":
          throw CustomException(message: LocaleKeys.tooManyRequests);
        case "internal-error":
          throw CustomException(message: LocaleKeys.internalError);
        case "popup-blocked":
        case "popup-closed-by-user":
          throw CustomException(message: LocaleKeys.popupBlocked);
        case "account-exists-with-different-credential":
          throw CustomException(message: LocaleKeys.differentCredential);
        case "user-disabled":
          throw CustomException(message: LocaleKeys.userDisabled);
        default:
          throw CustomException(message: LocaleKeys.errorOccurredMessage);
      }
    }
  }

  Future<void> changeEmail({required String email}) async {
    try {
      final user = auth.currentUser;
      if (user == null) return;
      await user.verifyBeforeUpdateEmail(email);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "network-request-failed":
          throw CustomException(message: LocaleKeys.noInternet);
        case "operation-not-allowed":
          throw CustomException(message: LocaleKeys.operationNotAllowed);
        case "too-many-requests":
          throw CustomException(message: LocaleKeys.tooManyRequests);
        case "internal-error":
          throw CustomException(message: LocaleKeys.internalError);
        case "popup-blocked":
        case "popup-closed-by-user":
          throw CustomException(message: LocaleKeys.popupBlocked);
        case "account-exists-with-different-credential":
          throw CustomException(message: LocaleKeys.differentCredential);
        case "user-disabled":
          throw CustomException(message: LocaleKeys.userDisabled);
        default:
          throw CustomException(message: LocaleKeys.errorOccurredMessage);
      }
    }
  }
}

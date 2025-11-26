// ignore_for_file: file_names, camel_case_types, depend_on_referenced_packages

import 'dart:async';
import 'dart:convert';
import 'dart:math' as math;

import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:sintir/Core/errors/Exceptioons.dart';
import 'package:sintir/locale_keys.dart';

class firebaseAuthService {
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<User> createUserWithEmailAndPassword(
      String email, String password, String name) async {
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
      final GoogleSignIn signIn = GoogleSignIn.instance;
      await signIn.initialize();
      if (!signIn.supportsAuthenticate()) {
        throw CustomException(message: LocaleKeys.errorOccurredMessage);
      }

      final GoogleSignInAccount user = await signIn.authenticate();
      final GoogleSignInClientAuthorization? auth =
          await user.authorizationClient.authorizationForScopes([
        'email',
        'openid',
        'https://www.googleapis.com/auth/userinfo.email',
      ]);

      if (auth == null) {
        throw CustomException(message: LocaleKeys.errorOccurredMessage);
      }

      final String? idToken = user.authentication.idToken;
      if (idToken == null) {
        throw CustomException(message: LocaleKeys.errorOccurredMessage);
      }

      final String accessToken = auth.accessToken;

      final OAuthCredential credential = GoogleAuthProvider.credential(
        idToken: idToken,
        accessToken: accessToken,
      );

      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      return userCredential.user!;
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

  Future<User> signInWithApple() async {
    final rawNonce = generateNonce();
    final nonce = sha256ofString(rawNonce);

    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      nonce: nonce,
    );

    final oauthCredential = OAuthProvider("apple.com")
        .credential(idToken: appleCredential.identityToken, rawNonce: rawNonce);

    final UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(oauthCredential);
    return userCredential.user!;
  }

  Future<void> deleteUSer() async {
    await auth.currentUser!.delete();
  }

  Future<void> signout() async {
    await auth.signOut();
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

      AuthCredential credential =
          EmailAuthProvider.credential(email: user.email!, password: password);

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

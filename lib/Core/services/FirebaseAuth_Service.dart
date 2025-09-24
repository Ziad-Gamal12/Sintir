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
      if (e.code == 'weak-password') {
        throw CustomException(message: 'الرقم السري ضعيف');
      } else if (e.code == 'email-already-in-use') {
        throw CustomException(message: 'البريد الالكتروني مستخدم من قبل');
      } else if (e.code == "network-request-failed") {
        throw CustomException(message: "لا يوجد اتصال بالانترنت");
      } else if (e.code == "operation-not-allowed") {
        throw CustomException(message: " لا يمكنك انشاء حساب جديد الان");
      } else if (e.code == "too-many-requests") {
        throw CustomException(
          message: " عذراً لقد تم تجاوز عدد المحاولات المسموح بها",
        );
      } else if (e.code == "internal-error") {
        throw CustomException(
          message: "هناك عطل داخلى سوف يتم حل هذا العطل فى اقرب وقت",
        );
      } else if (e.code == "account-exists-with-different-credential") {
        throw CustomException(
          message: "البريد الالكتروني مستخدم من قبل بخاصتك",
        );
      } else {
        throw CustomException(message: "حدث خطأ ما");
      }
    } catch (e) {
      throw CustomException(message: "حدث خطأ ما");
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
      if (e.code == 'user-not-found') {
        throw CustomException(message: 'لا يوجد مستخدم بهذا البريد الالكتروني');
      } else if (e.code == 'wrong-password') {
        throw CustomException(message: 'كلمة المرور غير صحيحة');
      } else if (e.code == "invalid-credential") {
        throw CustomException(
          message: "البريد الالكتروني او كلمة المرور غير صحيحة",
        );
      } else if (e.code == "too-many-requests") {
        throw CustomException(
          message: " عذراً لقد تم تجاوز عدد المحاولات المسموح بها",
        );
      } else if (e.code == 'network-request-failed') {
        throw CustomException(message: "لا يوجد اتصال بالانترنت");
      } else if (e.code == "internal-error") {
        throw CustomException(
          message: "هناك عطل داخلى سوف يتم حل هذا العطل فى اقرب وقت",
        );
      } else if (e.code == "account-exists-with-different-credential") {
        throw CustomException(
          message: "البريد الالكتروني مستخدم من قبل بخاصتك",
        );
      } else if (e.code == "operation-not-allowed") {
        throw CustomException(message: " لا يمكنك تسجيل الدخول الان");
      } else if (e.code == "user-disabled") {
        throw CustomException(message: "تم تعطيل حسابك");
      } else {
        throw CustomException(message: "حدث خطأ ما");
      }
    } catch (e) {
      throw CustomException(message: "حدث خطأ ما");
    }
  }

  Future<User> signinWithGoogle() async {
    try {
      final GoogleSignIn signIn = GoogleSignIn.instance;

      await signIn.initialize();

      if (!signIn.supportsAuthenticate()) {
        throw CustomException(message: "لا يمكن تسجيل الدخول");
      }

      final GoogleSignInAccount user = await signIn.authenticate();

      final GoogleSignInClientAuthorization? auth =
          await user.authorizationClient.authorizationForScopes([
        'email',
        'openid',
        'https://www.googleapis.com/auth/userinfo.email',
      ]);

      if (auth == null) {
        throw CustomException(message: "حدث خطاء في تسجيل الدخول");
      }

      final String? idToken = user.authentication.idToken;

      if (idToken == null) {
        throw CustomException(message: "حدث خطاء في تسجيل الدخول");
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
      if (e.code == "network-request-failed") {
        throw CustomException(message: "لا يوجد اتصال بالانترنت");
      } else if (e.code == "operation-not-allowed") {
        throw CustomException(message: " لا يمكنك تسجيل الدخول الان");
      } else if (e.code == "too-many-requests") {
        throw CustomException(
          message: " عذراً لقد تم تجاوز عدد المحاولات المسموح بها",
        );
      } else if (e.code == "internal-error") {
        throw CustomException(
          message: "هناك عطل داخلى سوف يتم حل هذا العطل فى اقرب وقت",
        );
      } else if (e.code == "popup-blocked") {
        throw CustomException(message: "المستخدم قام بحظر النافذة الجديدة");
      } else if (e.code == "popup-closed-by-user") {
        throw CustomException(message: "المستخدم قام بحظر النافذة الجديدة");
      } else if (e.code == "account-exists-with-different-credential") {
        throw CustomException(
          message: "البريد الالكتروني مستخدم من قبل بخاصتك",
        );
      } else if (e.code == "user-disabled") {
        throw CustomException(message: "تم تعطيل حسابك");
      } else {
        throw CustomException(message: "حدث خطأ ما");
      }
    } catch (e) {
      throw CustomException(message: "حدث خطأ ما");
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
          throw CustomException(message: "المستخدم غير موجود");
        }
      } else {
        throw CustomException(message: "حدث خطاء في تسجيل الدخول");
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == "network-request-failed") {
        throw CustomException(message: "لا يوجد اتصال بالانترنت");
      } else if (e.code == "operation-not-allowed") {
        throw CustomException(message: " لا يمكنك تسجيل الدخول الان");
      } else if (e.code == "too-many-requests") {
        throw CustomException(
          message: " عذراً لقد تم تجاوز عدد المحاولات المسموح بها",
        );
      } else if (e.code == "internal-error") {
        throw CustomException(
          message: "هناك عطل داخلى سوف يتم حل هذا العطل فى اقرب وقت",
        );
      } else if (e.code == "popup-blocked") {
        throw CustomException(message: "المستخدم قام بحظر النافذة الجديدة");
      } else if (e.code == "popup-closed-by-user") {
        throw CustomException(message: "المستخدم قام بحظر النافذة الجديدة");
      } else if (e.code == "account-exists-with-different-credential") {
        throw CustomException(
          message: "البريد الالكتروني مستخدم من قبل بخاصتك",
        );
      } else if (e.code == "user-disabled") {
        throw CustomException(message: "تم تعطيل حسابك");
      } else {
        throw CustomException(message: "حدث خطأ ما");
      }
    } catch (e) {
      throw CustomException(message: "حدث خطأ ما");
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

  /// Returns the sha256 hash of [input] in hex notation.
  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<User> signInWithApple() async {
    // To prevent replay attacks with the credential returned from Apple, we
    // include a nonce in the credential request. When signing in with
    // Firebase, the nonce in the id token returned by Apple, is expected to
    // match the sha256 hash of `rawNonce`.
    final rawNonce = generateNonce();
    final nonce = sha256ofString(rawNonce);

    // Request credential for the currently signed in Apple account.
    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      nonce: nonce,
    );

    // Create an `OAuthCredential` from the credential returned by Apple.
    final oauthCredential = OAuthProvider(
      "apple.com",
    ).credential(idToken: appleCredential.identityToken, rawNonce: rawNonce);

    // Sign in the user with Firebase. If the nonce we generated earlier does
    // not match the nonce in `appleCredential.identityToken`, sign in will fail.
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
    final currentUser = auth.currentUser;
    return currentUser != null;
  }

  Future<void> resetPassword({required String email}) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw CustomException(message: 'لا يوجد مستخدم بهذا البريد الالكتروني');
      } else if (e.code == "network-request-failed") {
        throw CustomException(message: "لا يوجد اتصال بالانترنت");
      } else if (e.code == "internal-error") {
        throw CustomException(
          message: "هناك عطل داخلى سوف يتم حل هذا العطل فى اقرب وقت",
        );
      } else if (e.code == "user-disabled") {
        throw CustomException(message: "تم تعطيل حسابك");
      } else if (e.code == "too-many-requests") {
        throw CustomException(
          message: "لقد تم تجميع الطلبات المسموح بها من قبل",
        );
      } else if (e.code == "invalid-email") {
        throw CustomException(message: "البريد الالكتروني غير صالح");
      } else {
        throw CustomException(message: "حدث خطأ ما");
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
    } on FirebaseAuthException catch (e, s) {
      if (e.code == "network-request-failed") {
        throw CustomException(message: "لا يوجد اتصال بالانترنت");
      } else if (e.code == "operation-not-allowed") {
        throw CustomException(message: " لا يمكنك تسجيل الدخول الان");
      } else if (e.code == "too-many-requests") {
        throw CustomException(
          message: " عذراً لقد تم تجاوز عدد المحاولات المسموح بها",
        );
      } else if (e.code == "invalid-credential") {
        throw CustomException(
          message:
              "لقد تم تمرير بيانات غير صحيحة. تأكد من المدخلات وحاول مجددًا",
        );
      } else if (e.code == "internal-error") {
        throw CustomException(
          message: "هناك عطل داخلى سوف يتم حل هذا العطل فى اقرب وقت",
        );
      } else if (e.code == "popup-blocked") {
        throw CustomException(message: "المستخدم قام بحظر النافذة الجديدة");
      } else if (e.code == "popup-closed-by-user") {
        throw CustomException(message: "المستخدم قام بحظر النافذة الجديدة");
      } else if (e.code == "account-exists-with-different-credential") {
        throw CustomException(
          message: "البريد الالكتروني مستخدم من قبل بخاصتك",
        );
      } else if (e.code == "user-disabled") {
        throw CustomException(message: "تم تعطيل حسابك");
      } else {
        throw CustomException(message: "حدث خطأ ما");
      }
    } catch (e, s) {
      throw CustomException(message: "حدث خطأ ما");
    }
  }

  Future<void> changePassword({required String password}) async {
    try {
      final user = auth.currentUser;
      if (user == null) return;
      await user.updatePassword(password);
    } on FirebaseAuthException catch (e) {
      if (e.code == "network-request-failed") {
        throw CustomException(message: "لا يوجد اتصال بالانترنت");
      } else if (e.code == "operation-not-allowed") {
        throw CustomException(message: " لا يمكنك تسجيل الدخول الان");
      } else if (e.code == "too-many-requests") {
        throw CustomException(
          message: " عذراً لقد تم تجاوز عدد المحاولات المسموح بها",
        );
      } else if (e.code == "internal-error") {
        throw CustomException(
          message: "هناك عطل داخلى سوف يتم حل هذا العطل فى اقرب وقت",
        );
      } else if (e.code == "popup-blocked") {
        throw CustomException(message: "المستخدم قام بحظر النافذة الجديدة");
      } else if (e.code == "popup-closed-by-user") {
        throw CustomException(message: "المستخدم قام بحظر النافذة الجديدة");
      } else if (e.code == "account-exists-with-different-credential") {
        throw CustomException(
          message: "البريد الالكتروني مستخدم من قبل بخاصتك",
        );
      } else if (e.code == "user-disabled") {
        throw CustomException(message: "تم تعطيل حسابك");
      } else {
        throw CustomException(message: "حدث خطأ ما");
      }
    } catch (e) {
      throw CustomException(message: "حدث خطأ ما");
    }
  }

  Future<void> changeEmail({required String email}) async {
    try {
      final user = auth.currentUser;
      if (user == null) return;
      await user.verifyBeforeUpdateEmail(email);
    } on FirebaseAuthException catch (e) {
      if (e.code == "network-request-failed") {
        throw CustomException(message: "لا يوجد اتصال بالانترنت");
      } else if (e.code == "operation-not-allowed") {
        throw CustomException(message: " لا يمكنك تسجيل الدخول الان");
      } else if (e.code == "too-many-requests") {
        throw CustomException(
          message: " عذراً لقد تم تجاوز عدد المحاولات المسموح بها",
        );
      } else if (e.code == "internal-error") {
        throw CustomException(
          message: "هناك عطل داخلى سوف يتم حل هذا العطل فى اقرب وقت",
        );
      } else if (e.code == "popup-blocked") {
        throw CustomException(message: "المستخدم قام بحظر النافذة الجديدة");
      } else if (e.code == "popup-closed-by-user") {
        throw CustomException(message: "المستخدم قام بحظر النافذة الجديدة");
      } else if (e.code == "account-exists-with-different-credential") {
        throw CustomException(
          message: "البريد الالكتروني مستخدم من قبل بخاصتك",
        );
      } else if (e.code == "user-disabled") {
        throw CustomException(message: "تم تعطيل حسابك");
      } else {
        throw CustomException(message: "حدث خطأ ما");
      }
    } catch (e) {
      throw CustomException(message: "حدث خطأ ما");
    }
  }
}

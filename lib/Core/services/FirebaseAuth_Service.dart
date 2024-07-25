import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sintir/Core/errors/Exceptioons.dart';

class firebaseAuthService {
  FirebaseAuth auth = FirebaseAuth.instance;
  Future<User> createUserWithEmailAndPassword(
      String email, String password, String name) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await credential.user!.updateDisplayName(name);
      await auth.currentUser!.reload();
      return auth.currentUser!;
    } on FirebaseAuthException catch (e) {
      log("Exception from FirebaseAuthService.createUserWithEmailAndPassword in catch With Firebase Exception: ${e.toString()} and the Firebase Code is ${e.code}");
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
            message: " عذراً لقد تم تجاوز عدد المحاولات المسموح بها");
      } else if (e.code == "internal-error") {
        throw CustomException(
            message: "هناك عطل داخلى سوف يتم حل هذا العطل فى اقرب وقت");
      } else if (e.code == "account-exists-with-different-credential") {
        throw CustomException(
            message: "البريد الالكتروني مستخدم من قبل بخاصتك");
      } else {
        throw CustomException(message: "حدث خطأ ما");
      }
    } catch (e) {
      log("Exception from FirebaseAuthService.createUserWithEmailAndPassword: ${e.toString()}");
      throw CustomException(message: "حدث خطأ ما");
    }
  }

  Future<User> signInWithEmailAndPassword(String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return credential.user!;
    } on FirebaseAuthException catch (e) {
      log("Exception from FirebaseAuthService.signInWithEmailAndPassword in catch With Firebase Exception: ${e.toString()} and the Firebase Code is ${e.code}");
      if (e.code == 'user-not-found') {
        throw CustomException(message: 'لا يوجد مستخدم بهذا البريد الالكتروني');
      } else if (e.code == 'wrong-password') {
        throw CustomException(message: 'كلمة المرور غير صحيحة');
      } else if (e.code == "invalid-credential") {
        throw CustomException(
            message: "البريد الالكتروني او كلمة المرور غير صحيحة");
      } else if (e.code == "too-many-requests") {
        throw CustomException(
            message: " عذراً لقد تم تجاوز عدد المحاولات المسموح بها");
      } else if (e.code == 'network-request-failed') {
        throw CustomException(message: "لا يوجد اتصال بالانترنت");
      } else if (e.code == "internal-error") {
        throw CustomException(
            message: "هناك عطل داخلى سوف يتم حل هذا العطل فى اقرب وقت");
      } else if (e.code == "account-exists-with-different-credential") {
        throw CustomException(
            message: "البريد الالكتروني مستخدم من قبل بخاصتك");
      } else if (e.code == "operation-not-allowed") {
        throw CustomException(message: " لا يمكنك تسجيل الدخول الان");
      } else if (e.code == "user-disabled") {
        throw CustomException(message: "تم تعطيل حسابك");
      } else {
        throw CustomException(message: "حدث خطأ ما");
      }
    } catch (e) {
      log("Exception from FirebaseAuthService.signInWithEmailAndPassword: ${e.toString()}");
      throw CustomException(message: "حدث خطأ ما");
    }
  }

  Future<User> signinWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      return userCredential.user!;
    } on FirebaseAuthException catch (e) {
      log("Exception from FirebaseAuthService.signinWithGoogle in catch With Firebase Exception: ${e.toString()} and the Firebase Code is ${e.code}");
      if (e.code == "network-request-failed") {
        throw CustomException(message: "لا يوجد اتصال بالانترنت");
      } else if (e.code == "operation-not-allowed") {
        throw CustomException(message: " لا يمكنك تسجيل الدخول الان");
      } else if (e.code == "too-many-requests") {
        throw CustomException(
            message: " عذراً لقد تم تجاوز عدد المحاولات المسموح بها");
      } else if (e.code == "internal-error") {
        throw CustomException(
            message: "هناك عطل داخلى سوف يتم حل هذا العطل فى اقرب وقت");
      } else if (e.code == "popup-blocked") {
        throw CustomException(message: "المستخدم قام بحظر النافذة الجديدة");
      } else if (e.code == "popup-closed-by-user") {
        throw CustomException(message: "المستخدم قام بحظر النافذة الجديدة");
      } else if (e.code == "account-exists-with-different-credential") {
        throw CustomException(
            message: "البريد الالكتروني مستخدم من قبل بخاصتك");
      } else if (e.code == "user-disabled") {
        throw CustomException(message: "تم تعطيل حسابك");
      } else {
        throw CustomException(message: "حدث خطأ ما");
      }
    } catch (e) {
      log("Exception from FirebaseAuthService.signInWithGoogle: ${e.toString()}");
      throw CustomException(message: "حدث خطأ ما");
    }
  }
}

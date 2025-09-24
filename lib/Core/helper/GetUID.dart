import 'package:firebase_auth/firebase_auth.dart';

String getUID() {
  if (FirebaseAuth.instance.currentUser != null) {
    return FirebaseAuth.instance.currentUser!.uid;
  } else {
    return "";
  }
}

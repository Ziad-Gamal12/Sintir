import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:sintir/Core/entities/CourseEntity.dart';

bool isSubscribed({
  required CourseEntity course,
}) {
  try {
    String userID = FirebaseAuth.instance.currentUser!.uid;
    for (var e in course.subscripersIDS) {
      if (e.id == userID) {
        return true;
      }
    }
  } on Exception catch (e) {
    log("Exception from isSubscribed in catch With Firebase Exception: ${e.toString()}");
    return false;
  }
  return false;
}

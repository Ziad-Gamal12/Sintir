// ignore_for_file: file_names

import 'dart:developer';

import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';

bool isSubscribed({
  required CourseEntity course,
}) {
  try {
    // String userID = FirebaseAuth.instance.currentUser!.uid;
    // for (var e in course) {
    //   if (e.id == userID) {
    //     return true;
    //   }
    // }
  } on Exception catch (e) {
    log("Exception from isSubscribed in catch With Firebase Exception: ${e.toString()}");
    return false;
  }
  return false;
}

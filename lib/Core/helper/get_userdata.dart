import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:sintir/Core/services/Shared_preferences.dart';
import 'package:sintir/Core/utils/Backend_EndPoints.dart';
import 'package:sintir/Features/StudenetAuth/data/model/studentAuth_model.dart';
import 'package:sintir/Features/StudenetAuth/domain/entities/studentEntity.dart';
import 'package:sintir/Features/TeacherAuth/Data/Models/TeacherModel.dart';
import 'package:sintir/Features/TeacherAuth/Domain/Entities/teacher_Entity.dart';

Either<teacherEntity, Studententity> getUserData() {
  // Retrieve the JSON string from shared preferences
  var jsonString = shared_preferences_Services.stringGetter(
      key: BackendEndpoints.saveUserData);

  // Check if the string is null or empty
  if (jsonString == null || jsonString.isEmpty) {
    throw Exception(
        'No user data found'); // Handle the case when no data is present
  }

  // Decode the JSON string into a Map
  var jsonMap = jsonDecode(jsonString);

  // Check if the map has a "kind" field and act accordingly
  if (jsonMap['kind'] == "teacher") {
    // Return the teacher data wrapped in Either.Left
    return left(Teachermodel.fromMap(jsonMap)
        as teacherEntity); // Assuming Teachermodel is already of type TeacherEntity
  } else if (jsonMap['kind'] == "student") {
    // Return the student data wrapped in Either.Right
    return right(StudentauthModel.fromJson(
        data: jsonMap)); // Assuming StudentauthModel is of type StudentEntity
  } else {
    throw Exception('Unknown user type'); // Handle unexpected cases
  }
}

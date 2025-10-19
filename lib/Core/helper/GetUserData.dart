// ignore_for_file: file_names

import 'dart:convert';

import 'package:sintir/Core/services/Shared_preferences.dart';
import 'package:sintir/Core/utils/Backend_EndPoints.dart';
import 'package:sintir/Features/Auth/Data/models/UserModel.dart';
import 'package:sintir/Features/Auth/Domain/Entities/UserEntity.dart';

UserEntity getUserData() {
  String userJsonString = shared_preferences_Services.stringGetter(
      key: BackendEndpoints.storeUserLocaly);
  if (userJsonString == " ") {
    return UserEntity.empty();
  } else {
    Map<String, dynamic> userJson = jsonDecode(userJsonString);
    UserEntity userEntity = UserModel.fromJson(userJson).toEntity();
    return userEntity;
  }
}

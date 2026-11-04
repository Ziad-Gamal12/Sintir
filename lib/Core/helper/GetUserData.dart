// ignore_for_file: file_names

import 'package:sintir/Core/services/HiveService.dart';
import 'package:sintir/Core/utils/Backend_EndPoints.dart';
import 'package:sintir/Features/Auth/Data/models/UserModel.dart';
import 'package:sintir/Features/Auth/Domain/Entities/UserEntity.dart';

UserEntity userEntityFromLocalJson(Map<String, dynamic> userJson) {
  if (userJson.isEmpty) return UserEntity.empty();
  return UserModel.fromJson(userJson).toEntity();
}

UserEntity getUserData() => userEntityFromLocalJson(
  Hive_Services.jsonGetter(key: BackendEndpoints.storeUserLocaly),
);

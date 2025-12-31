// ignore_for_file: file_names

import 'package:sintir/Core/services/HiveService.dart';
import 'package:sintir/Core/utils/Backend_EndPoints.dart';
import 'package:sintir/Features/Auth/Data/models/UserModel.dart';
import 'package:sintir/Features/Auth/Domain/Entities/UserEntity.dart';

UserEntity getUserData() {
  Map<String, dynamic> userJson = Hive_Services.jsonGetter(
    key: BackendEndpoints.storeUserLocaly,
  );
  if (userJson == {}) {
    return UserEntity.empty();
  } else {
    UserEntity userEntity = UserModel.fromJson(userJson).toEntity();
    return userEntity;
  }
}

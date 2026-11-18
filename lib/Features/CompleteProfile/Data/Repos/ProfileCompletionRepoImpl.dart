// ignore_for_file: file_names

import 'package:dartz/dartz.dart';
import 'package:sintir/Core/entities/FireStoreEntities/FireStoreRequirmentsEntity.dart';
import 'package:sintir/Core/errors/Exceptioons.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Core/helper/ProfileCompleteness.dart';
import 'package:sintir/Core/services/DataBaseService.dart';
import 'package:sintir/Core/utils/Backend_EndPoints.dart';
import 'package:sintir/Features/Auth/Data/models/UserModel.dart';
import 'package:sintir/Features/Auth/Domain/Entities/StudentExtraDataEntity.dart';
import 'package:sintir/Features/Auth/Domain/Entities/UserEntity.dart';
import 'package:sintir/Features/CompleteProfile/Domain/Entities/CompleteProfilePurpose.dart';
import 'package:sintir/Features/CompleteProfile/Domain/Repos/ProfileCompletionRepo.dart';
import 'package:sintir/locale_keys.dart';

class ProfileCompletionRepoImpl implements ProfileCompletionRepo {
  ProfileCompletionRepoImpl({
    required this.databaseService,
    required UserEntity Function() readCurrentUser,
    required Future<void> Function(Map<String, dynamic> userJson) saveLocalUser,
  }) : _readCurrentUser = readCurrentUser,
       _saveLocalUser = saveLocalUser;

  final DataBaseService databaseService;
  final UserEntity Function() _readCurrentUser;
  final Future<void> Function(Map<String, dynamic> userJson) _saveLocalUser;

  @override
  UserEntity currentUser() => _readCurrentUser();

  static String? validate(ProfileCompletionInput input) {
    if (input.firstName.trim().isEmpty) return LocaleKeys.enterFirstName;
    if (input.lastName.trim().isEmpty) return LocaleKeys.enterLastName;
    if (input.phoneNumber.trim().isEmpty) return LocaleKeys.phoneRequired;
    if (!ProfileCompleteness.isValidPhone(input.phoneNumber)) {
      return LocaleKeys.phoneInvalid;
    }
    if (!ProfileCompleteness.educationLevels.contains(input.educationLevel)) {
      return LocaleKeys.completeProfileLevelRequired;
    }
    return null;
  }

  static Map<String, dynamic> updateFields(
    UserEntity user,
    ProfileCompletionInput input,
  ) {
    final first = input.firstName.trim();
    final last = input.lastName.trim();
    final gender = input.gender.trim();
    return {
      'firstName': first,
      'lastName': last,
      'fullName': '$first $last',
      'phoneNumber': ProfileCompleteness.normalizePhone(input.phoneNumber),
      if (gender.isNotEmpty) 'gender': gender,
      'studentExtraData': {
        'educationLevel': input.educationLevel,
        'birthDate': user.studentExtraDataEntity?.birthDate,
      },
    };
  }

  static UserEntity applied(UserEntity user, Map<String, dynamic> fields) {
    return UserEntity(
      uid: user.uid,
      firstName: fields['firstName'] as String,
      lastName: fields['lastName'] as String,
      fullName: fields['fullName'] as String,
      email: user.email,
      address: user.address,
      phoneNumber: fields['phoneNumber'] as String,
      deviceId: user.deviceId,
      gender: (fields['gender'] as String?) ?? user.gender,
      profilePicurl: user.profilePicurl,
      status: user.status,
      role: user.role,
      joinedDate: user.joinedDate,
      teacherExtraDataEntity: user.teacherExtraDataEntity,
      studentExtraDataEntity: StudentExtraDataEntity(
        educationLevel:
            (fields['studentExtraData'] as Map)['educationLevel'] as String,
        birthDate: user.studentExtraDataEntity?.birthDate,
      ),
    );
  }

  @override
  Future<Either<Failure, UserEntity>> completeProfile(
    ProfileCompletionInput input,
  ) async {
    final invalid = validate(input);
    if (invalid != null) return Left(ServerFailure(message: invalid));
    try {
      final user = _readCurrentUser();
      if (user.uid.trim().isEmpty || user.uid == 'empty') {
        return Left(ServerFailure(message: LocaleKeys.userNotFound));
      }
      final fields = updateFields(user, input);
      await databaseService.updateData(
        requirements: FireStoreRequirmentsEntity(
          collection: BackendEndpoints.usersCollectionName,
          docId: user.uid,
        ),
        data: fields,
      );
      final updated = applied(user, fields);
      await _saveLocalUser(UserModel.fromEntity(updated).toMap());
      return Right(updated);
    } on CustomException catch (error) {
      return Left(ServerFailure(message: error.message));
    } catch (_) {
      return Left(ServerFailure(message: LocaleKeys.errorOccurredMessage));
    }
  }
}

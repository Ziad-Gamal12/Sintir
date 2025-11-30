// ignore_for_file: file_names

import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobile_device_identifier/mobile_device_identifier.dart';
import 'package:sintir/Core/entities/FireStoreEntities/FireStorePaginateResponse.dart';
import 'package:sintir/Core/entities/FireStoreEntities/FireStoreRequirmentsEntity.dart';
import 'package:sintir/Core/errors/Exceptioons.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Core/services/DataBaseService.dart';
import 'package:sintir/Core/services/FireBase/FirebaseAuth_Service.dart';
import 'package:sintir/Core/services/Shared_preferences.dart';
import 'package:sintir/Core/utils/Backend_EndPoints.dart';
import 'package:sintir/Features/Auth/Data/models/UserModel.dart';
import 'package:sintir/Features/Auth/Domain/Entities/UserEntity.dart';
import 'package:sintir/Features/Auth/Domain/Repos/AuthRepo.dart';
import 'package:sintir/locale_keys.dart';

class AuthRepoImpl implements AuthRepo {
  final firebaseAuthService authService;
  final DataBaseService databaseservice;

  AuthRepoImpl({required this.authService, required this.databaseservice});

  Failure _toFailure(Object e, [StackTrace? s]) {
    log('AuthRepoImpl error: $e', stackTrace: s);
    if (e is CustomException) return ServerFailure(message: e.message);
    return ServerFailure(message: LocaleKeys.generalError);
  }

  @override
  Future<Either<Failure, void>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      User user = await authService.signInWithEmailAndPassword(email, password);

      await user.reload();

      User? fresh = FirebaseAuth.instance.currentUser ?? user;

      if (fresh.emailVerified == false) {
        await fresh.sendEmailVerification();
        await authService.signout();
        return Left(ServerFailure(message: LocaleKeys.verificationSent));
      }
      final updateDeviceIdResult = await updateDeviceId(uid: fresh.uid);
      if (updateDeviceIdResult.isLeft()) {
        await authService.signout();
        return updateDeviceIdResult;
      }
      final result = await fetchUserAndStoreLocally(uid: fresh.uid);
      if (result.isLeft()) {
        await authService.signout();
        return result;
      }
      return const Right(null);
    } on CustomException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e, s) {
      return Left(_toFailure(e, s));
    }
  }

  @override
  Future<Either<Failure, void>> signUpWithEmailAndPassword({
    required UserEntity userEntity,
    required String password,
  }) async {
    User? user;
    try {
      user = await authService.createUserWithEmailAndPassword(
        userEntity.email,
        password,
        '${userEntity.firstName} ${userEntity.lastName}',
      );

      userEntity.uid = user.uid;
      userEntity.deviceId = await getDeviceId();
      if (userEntity.teacherExtraDataEntity != null) {
        userEntity.teacherExtraDataEntity!.wallet.teacherId = user.uid;
      }

      final userModel = UserModel.fromEntity(userEntity);

      return await storeUserDataInFireStore(
          user: user, userjson: userModel.toMap(), uid: user.uid);
    } on CustomException catch (e) {
      await _tryDeleteUser(user);
      return Left(ServerFailure(message: e.message));
    } catch (e, s) {
      await _tryDeleteUser(user);
      return Left(_toFailure(e, s));
    }
  }

  Future<void> _tryDeleteUser(User? user) async {
    if (user == null) return;
    try {
      await user.delete();
    } catch (e, s) {
      log('Failed to delete user during cleanup: $e', stackTrace: s);
    }
  }

  Future<void> storeUserLocally(Map<String, dynamic> userJson) async {
    try {
      String userJsonString = jsonEncode(userJson);
      await shared_preferences_Services.stringSetter(
        key: BackendEndpoints.storeUserLocaly,
        value: userJsonString,
      );
    } catch (e, s) {
      log('Failed to store user locally: $e', stackTrace: s);
      throw CustomException(message: LocaleKeys.errorOccurredMessage);
    }
  }

  @override
  Future<Either<Failure, void>> fetchUserAndStoreLocally(
      {required String uid}) async {
    try {
      FireStoreResponse json = await databaseservice.getData(
        requirements: FireStoreRequirmentsEntity(
          collection: BackendEndpoints.usersCollectionName,
          docId: uid,
        ),
      );

      if (json.docData == null) {
        return Left(ServerFailure(message: LocaleKeys.userNotFound));
      }

      final Map<String, dynamic> userJson = json.docData!;
      final UserEntity userEntity = UserModel.fromJson(userJson).toEntity();

      switch (userEntity.status) {
        case BackendEndpoints.activeStatus:
          await storeUserLocally(userJson);
          return const Right(null);

        case BackendEndpoints.blockedStatus:
          return Left(ServerFailure(message: LocaleKeys.userBlocked));

        case BackendEndpoints.pendingStatus:
          return Left(ServerFailure(message: LocaleKeys.userPending));

        case BackendEndpoints.rejectedStatus:
          return Left(ServerFailure(message: LocaleKeys.userRejected));

        case BackendEndpoints.inActiveStatus:
          return Left(ServerFailure(message: LocaleKeys.userInactive));

        default:
          return Left(ServerFailure(message: LocaleKeys.generalError));
      }
    } on CustomException catch (e) {
      await authService.signout();
      return Left(ServerFailure(message: e.message));
    } catch (e, s) {
      log(e.toString(), stackTrace: s);
      await authService.signout();
      return Left(_toFailure(e, s));
    }
  }

  @override
  Future<Either<Failure, void>> signInWithFacebook() async {
    bool isExists = false;
    User? user;
    try {
      user = await authService.signinWithFacebook();
      isExists = await databaseservice.isDataExists(
        key: BackendEndpoints.usersCollectionName,
        docId: user.uid,
      );

      if (isExists) {
        return await fetchUserAndStoreLocally(uid: user.uid);
      }

      final userJson = await _userJson(user: user);
      return await storeUserDataInFireStore(
          signOut: false, user: user, userjson: userJson, uid: user.uid);
    } catch (e, s) {
      if (isExists == false) {
        await _tryDeleteUser(user);
      } else {
        await authService.signout();
      }
      return Left(_toFailure(e, s));
    }
  }

  @override
  Future<Either<Failure, void>> signInWithGoogle() async {
    bool isExists = false;
    User? user;
    try {
      user = await authService.signinWithGoogle();
      isExists = await databaseservice.isDataExists(
        key: BackendEndpoints.usersCollectionName,
        docId: user.uid,
      );

      if (isExists) return await fetchUserAndStoreLocally(uid: user.uid);

      final userJson = await _userJson(user: user);
      return await storeUserDataInFireStore(
          signOut: false, user: user, userjson: userJson, uid: user.uid);
    } catch (e, s) {
      if (isExists == false) {
        await _tryDeleteUser(user);
      } else {
        await authService.signout();
      }
      return Left(_toFailure(e, s));
    }
  }

  Future<Either<Failure, void>> storeUserDataInFireStore({
    required Map<String, dynamic> userjson,
    required User user,
    required String uid,
    bool signOut = true,
    bool checkVerified = true,
  }) async {
    try {
      await databaseservice.setData(
        requirements: FireStoreRequirmentsEntity(
          collection: BackendEndpoints.usersCollectionName,
          docId: uid,
        ),
        data: userjson,
      );

      if (checkVerified) {
        try {
          await user.sendEmailVerification();
        } catch (e) {
          return Left(ServerFailure(message: LocaleKeys.verificationNotSent));
        }
      }

      if (signOut) await authService.signout();

      return const Right(null);
    } catch (e, s) {
      return Left(_toFailure(e, s));
    }
  }

  @override
  Future<Either<Failure, void>> updateUser(
    String? newPassword, {
    required UserEntity userEntity,
    required String currentPassword,
  }) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        return Left(ServerFailure(message: LocaleKeys.userNotFound));
      }

      Map<String, dynamic> userJson = UserModel.fromEntity(userEntity).toMap();

      bool isValid =
          await authService.checkAccountPassword(password: currentPassword);
      if (!isValid) {
        return Left(ServerFailure(message: LocaleKeys.wrongPassword));
      }

      if (newPassword != null && newPassword.isNotEmpty) {
        await authService.changePassword(password: newPassword);
      }

      if (userEntity.email != user.email) {
        await authService.changeEmail(email: userEntity.email);
      }

      final result = await storeUserDataInFireStore(
          user: user,
          userjson: userJson,
          uid: user.uid,
          signOut: false,
          checkVerified: false);

      if (result.isLeft()) return result;

      await storeUserLocally(userJson);
      return const Right(null);
    } catch (e, s) {
      return Left(ServerFailure(message: LocaleKeys.generalError));
    }
  }

  @override
  Future<Either<Failure, void>> resetPassword({required String email}) async {
    try {
      await authService.resetPassword(email: email);
      return const Right(null);
    } catch (e, s) {
      return Left(_toFailure(e, s));
    }
  }

  Future<Map<String, dynamic>> _userJson({required User user}) async {
    return UserModel.fromEntity(
      UserEntity(
        uid: user.uid,
        phoneNumber: user.phoneNumber ?? '',
        firstName: user.displayName ?? '',
        fullName: user.displayName ?? '',
        deviceId: await getDeviceId(),
        joinedDate: DateTime.now().toIso8601String(),
        profilePicurl: 'https://cdn-icons-png.flaticon.com/128/149/149071.png',
        role: BackendEndpoints.studentRole,
        lastName: '',
        email: user.email ?? '',
        status: BackendEndpoints.activeStatus,
        address: '',
        gender: "",
        teacherExtraDataEntity: null,
      ),
    ).toMap();
  }

  @override
  Future<String> getDeviceId() async {
    try {
      String? mobileDeviceIdentifier =
          await MobileDeviceIdentifier().getDeviceId();
      return mobileDeviceIdentifier ?? '';
    } catch (e, s) {
      log('Failed to fetch device id: $e', stackTrace: s);
      return '';
    }
  }

  Future<Either<Failure, void>> updateDeviceId({required String uid}) async {
    try {
      final deviceId = await getDeviceId();

      await databaseservice.updateData(
        collectionKey: BackendEndpoints.usersCollectionName,
        doc: uid,
        data: deviceId,
        field: 'deviceId',
      );

      return const Right(null);
    } catch (e, s) {
      return Left(_toFailure(e, s));
    }
  }
}

// ignore_for_file: file_names

import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sintir/Core/entities/FireStoreEntities/FireStoreRequirmentsEntity.dart';
import 'package:sintir/Core/errors/Exceptioons.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Core/services/DataBaseService.dart';
import 'package:sintir/Core/services/FireBase/FirebaseAuth_Service.dart';
import 'package:sintir/Core/services/HiveService.dart';
import 'package:sintir/Core/utils/Backend_EndPoints.dart';
import 'package:sintir/Features/Auth/Data/models/UserModel.dart';
import 'package:sintir/Features/Auth/Domain/Entities/UserEntity.dart';
import 'package:sintir/Features/Auth/Domain/Repos/AuthRepo.dart';
import 'package:sintir/locale_keys.dart';
import 'package:unique_device_identifier/unique_device_identifier.dart';

typedef DeviceIdReader = Future<String?> Function();
typedef LocalUserWriter = Future<void> Function(Map<String, dynamic> userJson);

class AuthRepoImpl implements AuthRepo {
  final firebaseAuthService authService;
  final DataBaseService databaseservice;

  final FirebaseAuth? _firebaseAuthOverride;
  final DeviceIdReader _deviceIdReader;
  final LocalUserWriter _localUserWriter;

  FirebaseAuth get _firebaseAuth =>
      _firebaseAuthOverride ?? FirebaseAuth.instance;

  AuthRepoImpl({
    required this.authService,
    required this.databaseservice,
    FirebaseAuth? firebaseAuth,
    DeviceIdReader? deviceIdReader,
    LocalUserWriter? localUserWriter,
  }) : _firebaseAuthOverride = firebaseAuth,
       _deviceIdReader = deviceIdReader ?? _readPlatformDeviceId,
       _localUserWriter = localUserWriter ?? _writeUserToHive;

  static Future<String?> _readPlatformDeviceId() async {
    return UniqueDeviceIdentifier.getUniqueIdentifier();
  }

  static Future<void> _writeUserToHive(Map<String, dynamic> userJson) async {
    await Hive_Services.jsonSetter(
      key: BackendEndpoints.storeUserLocaly,
      value: userJson,
    );
  }

  Failure _toFailure(Object error, [StackTrace? stackTrace]) {
    if (error is CustomException) {
      return ServerFailure(message: error.message);
    }

    if (error is FirebaseAuthException) {
      if (error.code == 'too-many-requests') {
        return ServerFailure(message: LocaleKeys.tooManyRequests);
      }

      final message = error.message;
      if (message != null && message.trim().isNotEmpty) {
        return ServerFailure(message: message);
      }
    }

    return ServerFailure(message: LocaleKeys.generalError);
  }

  Future<void> _safeSignOut() async {
    try {
      await authService.signout();
    } catch (error, stackTrace) {
      log('AuthRepoImpl: sign-out failed: $error', stackTrace: stackTrace);
    }
  }

  Future<void> _tryDeleteUser(User? user) async {
    if (user == null) return;

    try {
      await user.delete();
    } catch (error, stackTrace) {
      log(
        'AuthRepoImpl: rollback could not delete the newly-created user: $error',
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Future<String> getDeviceId() async {
    try {
      return (await _deviceIdReader())?.trim() ?? '';
    } catch (error) {
      return '';
    }
  }

  Future<String> _requireDeviceId() async {
    final deviceId = await getDeviceId();
    if (deviceId.isEmpty) {
      throw CustomException(message: LocaleKeys.generalError);
    }
    return deviceId;
  }

  Future<void> _persistDeviceId({
    required String uid,
    required String deviceId,
  }) async {
    await databaseservice.updateData(
      requirements: FireStoreRequirmentsEntity(
        collection: BackendEndpoints.usersCollectionName,
        docId: uid,
      ),
      data: deviceId,
      field: 'deviceId',
    );
  }

  Future<Either<Failure, void>> updateDeviceId({required String uid}) async {
    try {
      if (uid.trim().isEmpty) {
        return Left(ServerFailure(message: LocaleKeys.userNotFound));
      }

      final deviceId = await _requireDeviceId();
      await _persistDeviceId(uid: uid, deviceId: deviceId);
      return const Right(null);
    } catch (error, stackTrace) {
      return Left(_toFailure(error, stackTrace));
    }
  }

  @override
  Future<Either<Failure, void>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final signedInUser = await authService.signInWithEmailAndPassword(
        email,
        password,
      );

      await signedInUser.reload();
      final freshUser = _firebaseAuth.currentUser ?? signedInUser;

      if (freshUser.emailVerified == false) {
        try {
          await freshUser.sendEmailVerification();
        } catch (error) {
          await _safeSignOut();
          return Left(ServerFailure(message: LocaleKeys.verificationNotSent));
        }

        await _safeSignOut();
        return Left(ServerFailure(message: LocaleKeys.verificationSent));
      }

      return await _completeExistingUserSignIn(uid: freshUser.uid);
    } on FirebaseAuthException catch (error, stackTrace) {
      await _safeSignOut();
      return Left(_toFailure(error, stackTrace));
    } catch (error) {
      await _safeSignOut();
      return Left(_toFailure(error));
    }
  }

  @override
  Future<Either<Failure, void>> signUpWithEmailAndPassword({
    required UserEntity userEntity,
    required String password,
  }) async {
    User? createdUser;
    var firestoreWriteCompleted = false;

    try {
      final deviceId = await _requireDeviceId();

      createdUser = await authService.createUserWithEmailAndPassword(
        userEntity.email,
        password,
        '${userEntity.firstName} ${userEntity.lastName}'.trim(),
      );

      userEntity.uid = createdUser.uid;
      userEntity.deviceId = deviceId;
      if (userEntity.teacherExtraDataEntity != null) {
        userEntity.teacherExtraDataEntity!.wallet.teacherId = createdUser.uid;
      }

      final userJson = UserModel.fromEntity(userEntity).toMap();
      userJson['uid'] = createdUser.uid;
      userJson['deviceId'] = deviceId;

      await databaseservice.setData(
        requirements: FireStoreRequirmentsEntity(
          collection: BackendEndpoints.usersCollectionName,
          docId: createdUser.uid,
        ),
        data: userJson,
      );
      firestoreWriteCompleted = true;
      try {
        await createdUser.sendEmailVerification();
      } catch (error) {
        await _safeSignOut();
        return Left(ServerFailure(message: LocaleKeys.verificationNotSent));
      }

      await _safeSignOut();
      return const Right(null);
    } on FirebaseAuthException catch (error) {
      if (createdUser != null && !firestoreWriteCompleted) {
        await _tryDeleteUser(createdUser);
      }
      await _safeSignOut();
      return Left(_toFailure(error));
    } catch (error) {
      if (createdUser != null && !firestoreWriteCompleted) {
        await _tryDeleteUser(createdUser);
      }
      await _safeSignOut();
      return Left(_toFailure(error));
    }
  }

  @override
  Future<Either<Failure, void>> fetchUserAndStoreLocally({
    required String uid,
  }) async {
    try {
      final userJson = await _fetchActiveUserJson(uid: uid);
      await storeUserLocally(userJson);
      return const Right(null);
    } catch (error) {
      await _safeSignOut();
      return Left(_toFailure(error));
    }
  }

  Future<Map<String, dynamic>> _fetchActiveUserJson({
    required String uid,
  }) async {
    if (uid.trim().isEmpty) {
      throw CustomException(message: LocaleKeys.userNotFound);
    }

    final response = await databaseservice.getData(
      requirements: FireStoreRequirmentsEntity(
        collection: BackendEndpoints.usersCollectionName,
        docId: uid,
      ),
    );

    final documentData = response.docData;
    if (documentData == null) {
      throw CustomException(message: LocaleKeys.userNotFound);
    }

    final userModel = UserModel.fromJson(
      Map<String, dynamic>.from(documentData),
    );

    switch (userModel.status) {
      case BackendEndpoints.activeStatus:
        return userModel.toMap();
      case BackendEndpoints.blockedStatus:
        throw CustomException(message: LocaleKeys.userBlocked);
      case BackendEndpoints.pendingStatus:
        throw CustomException(message: LocaleKeys.userPending);
      case BackendEndpoints.rejectedStatus:
        throw CustomException(message: LocaleKeys.userRejected);
      case BackendEndpoints.inActiveStatus:
        throw CustomException(message: LocaleKeys.userInactive);
      default:
        throw CustomException(message: LocaleKeys.generalError);
    }
  }

  Future<Either<Failure, void>> _completeExistingUserSignIn({
    required String uid,
  }) async {
    try {
      final userJson = await _fetchActiveUserJson(uid: uid);
      final deviceId = await _requireDeviceId();
      final storedDeviceId = userJson['deviceId']?.toString().trim() ?? '';

      if (storedDeviceId != deviceId) {
        await _persistDeviceId(uid: uid, deviceId: deviceId);
      }

      userJson['deviceId'] = deviceId;
      await storeUserLocally(userJson);
      return const Right(null);
    } catch (error) {
      await _safeSignOut();
      return Left(_toFailure(error));
    }
  }

  @override
  Future<Either<Failure, void>> signInWithFacebook() {
    return _signInWithSocialProvider(signIn: authService.signinWithFacebook);
  }

  @override
  Future<Either<Failure, void>> signInWithGoogle() {
    return _signInWithSocialProvider(signIn: authService.signinWithGoogle);
  }

  Future<Either<Failure, void>> _signInWithSocialProvider({
    required Future<User> Function() signIn,
  }) async {
    try {
      final user = await signIn();
      final exists = await databaseservice.isDataExists(
        key: BackendEndpoints.usersCollectionName,
        docId: user.uid,
      );

      if (exists) {
        return _completeExistingUserSignIn(uid: user.uid);
      }
      final userJson = await _userJson(user: user);
      await databaseservice.setData(
        requirements: FireStoreRequirmentsEntity(
          collection: BackendEndpoints.usersCollectionName,
          docId: user.uid,
        ),
        data: userJson,
      );
      await storeUserLocally(userJson);
      return const Right(null);
    } catch (error) {
      await _safeSignOut();
      return Left(_toFailure(error));
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
        } catch (error) {
          if (signOut) await _safeSignOut();
          return Left(ServerFailure(message: LocaleKeys.verificationNotSent));
        }
      }

      if (signOut) await _safeSignOut();
      return const Right(null);
    } catch (error) {
      if (signOut) await _safeSignOut();
      return Left(_toFailure(error));
    }
  }

  @override
  Future<Either<Failure, void>> updateUser(
    String? newPassword, {
    required UserEntity userEntity,
    required String currentPassword,
  }) async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user == null) {
        return Left(ServerFailure(message: LocaleKeys.userNotFound));
      }

      final isValid = await authService.checkAccountPassword(
        password: currentPassword,
      );
      if (!isValid) {
        return Left(ServerFailure(message: LocaleKeys.wrongPassword));
      }

      final userJson = UserModel.fromEntity(userEntity).toMap();
      userJson['uid'] = user.uid;

      if (newPassword != null && newPassword.isNotEmpty) {
        await authService.changePassword(password: newPassword);
      }

      final newEmail = userEntity.email.trim();
      final currentEmail = (user.email ?? '').trim();
      if (newEmail.toLowerCase() != currentEmail.toLowerCase()) {
        await authService.changeEmail(email: newEmail);
      }

      final saveResult = await storeUserDataInFireStore(
        user: user,
        userjson: userJson,
        uid: user.uid,
        signOut: false,
        checkVerified: false,
      );

      if (saveResult.isLeft()) return saveResult;

      await storeUserLocally(userJson);
      return const Right(null);
    } on FirebaseAuthException catch (error, stackTrace) {
      return Left(_toFailure(error, stackTrace));
    } catch (error) {
      return Left(_toFailure(error));
    }
  }

  @override
  Future<Either<Failure, void>> resetPassword({required String email}) async {
    try {
      await authService.resetPassword(email: email);
      return const Right(null);
    } on FirebaseAuthException catch (error, stackTrace) {
      return Left(_toFailure(error, stackTrace));
    } catch (error) {
      return Left(_toFailure(error));
    }
  }

  Future<Map<String, dynamic>> _userJson({required User user}) async {
    final deviceId = await _requireDeviceId();

    return UserModel.fromEntity(
      UserEntity(
        uid: user.uid,
        phoneNumber: user.phoneNumber ?? '',
        firstName: user.displayName ?? '',
        fullName: user.displayName ?? '',
        deviceId: deviceId,
        joinedDate: DateTime.now(),
        profilePicurl:
            'https://lsblauupczaxktmrpsmv.supabase.co/storage/v1/object/public/Users/149071.png',
        role: BackendEndpoints.studentRole,
        lastName: '',
        email: user.email ?? '',
        status: BackendEndpoints.activeStatus,
        address: '',
        gender: '',
        teacherExtraDataEntity: null,
      ),
    ).toMap();
  }

  Future<void> storeUserLocally(Map<String, dynamic> userJson) async {
    try {
      await _localUserWriter(userJson);
    } catch (error) {
      throw CustomException(message: LocaleKeys.errorOccurredMessage);
    }
  }
}

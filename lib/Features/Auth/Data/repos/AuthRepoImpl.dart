// ignore_for_file: file_names

import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sintir/Core/entities/FireStorePaginateResponse.dart';
import 'package:sintir/Core/entities/FireStoreRequirmentsEntity.dart';
import 'package:sintir/Core/errors/Exceptioons.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Core/services/DataBaseService.dart';
import 'package:sintir/Core/services/FirebaseAuth_Service.dart';
import 'package:sintir/Core/services/Shared_preferences.dart';
import 'package:sintir/Core/utils/Backend_EndPoints.dart';
import 'package:sintir/Features/Auth/Data/models/UserModel.dart';
import 'package:sintir/Features/Auth/Domain/Entities/UserEntity.dart';
import 'package:sintir/Features/Auth/Domain/Repos/AuthRepo.dart';

class AuthRepoImpl implements AuthRepo {
  final firebaseAuthService authService;
  final Databaseservice databaseservice;
  AuthRepoImpl({required this.authService, required this.databaseservice});

  @override
  Future<Either<Failure, void>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      User user = await authService.signInWithEmailAndPassword(email, password);
      if (user.emailVerified == false) {
        await user.sendEmailVerification();
        await authService.signout();
        return Left(ServerFailure(
            message:
                "📩 بعتنالك رسالة تأكيد على إيميلك، لو مش لاقيها في الـ Inbox بص في الـ Spam."));
      } else {
        final result = await fetchUserAndStoreLocally(user.uid);
        if (result.isLeft()) {
          authService.signout();
          return result;
        } else {
          return const Right(null);
        }
      }
    } on CustomException catch (e) {
      log(e.message);
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: "حدث خطأ ما"));
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
        "${userEntity.firstName} ${userEntity.lastName}",
      );
      userEntity.uid = user.uid;
      final userModel = UserModel.fromEntity(userEntity);

      return await storeUserDataInFireStore(
          user: user, userjson: userModel.toMap(), uid: user.uid);
    } on CustomException catch (e) {
      deleteUser(user);
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      deleteUser(user);
      return Left(ServerFailure(message: "حدث خطأ ما"));
    }
  }

  Future<void> deleteUser(User? user) async {
    try {
      if (user != null) {
        await user.delete();
      }
    } catch (e, s) {
      ("$e\n$s");

      throw CustomException(message: "حدث خطأ أثناء حذف المستخدم");
    }
  }

  Future<void> storeUserLocally(Map<String, dynamic> userJson) async {
    String userJsonString = jsonEncode(userJson);
    await shared_preferences_Services.stringSetter(
      key: BackendEndpoints.storeUserLocaly,
      value: userJsonString,
    );
  }

  Future<Either<Failure, void>> fetchUserAndStoreLocally(String uid) async {
    try {
      FireStoreResponse json = await databaseservice.getData(
        requirements: FireStoreRequirmentsEntity(
          collection: BackendEndpoints.usersCollectionName,
          docId: uid,
        ),
      );
      if (json.docData != null) {
        Map<String, dynamic> userJson = json.docData!;
        UserEntity userEntity = UserModel.fromJson(userJson).toEntity();
        if (userEntity.status == BackendEndpoints.activeStatus) {
          await storeUserLocally(userJson);
          return const Right(null);
        } else if (userEntity.status == BackendEndpoints.blockedStatus) {
          return Left(ServerFailure(message: "لقد تم حظرك من التطبيق"));
        } else if (userEntity.status == BackendEndpoints.pendingStatus) {
          return Left(
              ServerFailure(message: "لقد تم انشاء حسابك بانتظار الموافقة"));
        } else if (userEntity.status == BackendEndpoints.rejectedStatus) {
          return Left(ServerFailure(message: "لقد تم رفض حسابك"));
        } else if (userEntity.status == BackendEndpoints.inActiveStatus) {
          return Left(ServerFailure(message: "لقد تم تعطيل حسابك"));
        } else {
          return Left(ServerFailure(message: "حدث خطأ ما"));
        }
      } else {
        return Left(ServerFailure(message: "لم يتم العثور على المستخدم"));
      }
    } on CustomException catch (e) {
      authService.signout();
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      authService.signout();
      return Left(ServerFailure(message: "حدث خطأ ما"));
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
        return await fetchUserAndStoreLocally(user.uid);
      } else {
        return await storeUserDataInFireStore(
          signOut: false,
          user: user,
          userjson: UserModel.fromEntity(
            UserEntity(
                uid: user.uid,
                phoneNumber: user.phoneNumber ?? "",
                firstName: user.displayName ?? "",
                fullName: user.displayName ?? "",
                joinedDate: DateTime.now().toString(),
                profilePicurl:
                    "https://cdn-icons-png.flaticon.com/128/149/149071.png",
                role: BackendEndpoints.studentRole,
                lastName: "",
                email: user.email ?? "",
                status: BackendEndpoints.activeStatus,
                address: "",
                gender: "غير محدد",
                teacherExtraDataEntity: null),
          ).toMap(),
          uid: user.uid,
        );
      }
    } on CustomException catch (e) {
      if (isExists == false) {
        deleteUser(user);
      } else {
        await authService.signout();
      }
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      if (isExists == false) {
        deleteUser(user);
      } else {
        await authService.signout();
      }
      return Left(ServerFailure(message: "حدث خطأ ما"));
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
      if (isExists) {
        return await fetchUserAndStoreLocally(user.uid);
      } else {
        return await storeUserDataInFireStore(
          signOut: false,
          user: user,
          userjson: UserModel.fromEntity(
            UserEntity(
                uid: user.uid,
                phoneNumber: user.phoneNumber ?? "",
                firstName: user.displayName ?? "",
                fullName: user.displayName ?? "",
                joinedDate: DateTime.now().toString(),
                profilePicurl:
                    "https://cdn-icons-png.flaticon.com/128/149/149071.png",
                role: BackendEndpoints.studentRole,
                lastName: "",
                email: user.email ?? "",
                status: BackendEndpoints.activeStatus,
                address: "",
                gender: "غير محدد",
                teacherExtraDataEntity: null),
          ).toMap(),
          uid: user.uid,
        );
      }
    } on CustomException catch (e) {
      if (isExists == false) {
        deleteUser(user);
      } else {
        await authService.signout();
      }
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      if (isExists == false) {
        deleteUser(user);
      } else {
        await authService.signout();
      }
      return Left(ServerFailure(message: "حدث خطأ ما"));
    }
  }

  Future<Either<Failure, void>> storeUserDataInFireStore(
      {required Map<String, dynamic> userjson,
      required User user,
      required String uid,
      bool signOut = true,
      bool checkVerified = true}) async {
    try {
      await databaseservice.setData(
        requirements: FireStoreRequirmentsEntity(
          collection: BackendEndpoints.usersCollectionName,
          docId: uid,
        ),
        data: userjson,
      );
      if (checkVerified == true) {
        await user.sendEmailVerification();
      }
      if (signOut == true) {
        await authService.signout();
      }
      return const Right(null);
    } on CustomException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: "حدث خطأ ما"));
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
      Map<String, dynamic> userJson = UserModel.fromEntity(userEntity).toMap();
      if (user != null) {
        bool isValid =
            await authService.checkAccountPassword(password: currentPassword);
        if (isValid) {
          if (newPassword != null) {
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

          if (result.isLeft()) {
            return result;
          } else {
            await storeUserLocally(userJson);
            return const Right(null);
          }
        } else {
          return Left(ServerFailure(message: "كلمة المرور غير صحيحة"));
        }
      } else {
        return Left(ServerFailure(message: "المستخدم غير موجود"));
      }
    } on CustomException catch (e, s) {
      ("$e $s");
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      ("$e");
      return Left(ServerFailure(message: "حدث خطأ ما"));
    }
  }

  @override
  Future<Either<Failure, void>> resetPassword({required String email}) async {
    try {
      await authService.resetPassword(email: email);
      return const Right(null);
    } on CustomException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: "حدث خطأ ما"));
    }
  }
}

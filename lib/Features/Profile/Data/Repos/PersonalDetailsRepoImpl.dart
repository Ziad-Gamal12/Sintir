import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:sintir/Core/errors/Exceptioons.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Core/repos/AssetsPickerRepo/AssetsPickerRepo.dart';
import 'package:sintir/Core/services/DataBaseService.dart';
import 'package:sintir/Core/services/StorageService.dart';
import 'package:sintir/Core/utils/Backend_EndPoints.dart';
import 'package:sintir/Features/Auth/Domain/Repos/AuthRepo.dart';
import 'package:sintir/Features/Profile/Domain/Repos/PersonalDetailsRepo.dart';
import 'package:sintir/locale_keys.dart';

class PersonalDetailsRepoImpl implements PersonalDetailsRepo {
  final Assetspickerrepo assetspickerrepo;
  final DataBaseService dataBaseService;
  final StorageService storageService;
  final AuthRepo authRepo;

  PersonalDetailsRepoImpl({
    required this.storageService,
    required this.assetspickerrepo,
    required this.dataBaseService,
    required this.authRepo,
  });

  @override
  Future<Either<Failure, void>> updatedUserProfilePic({
    required String uid,
  }) async {
    try {
      // pick image
      final result = await assetspickerrepo.pickImageFromGallery();

      // user cancelled
      if (result.isLeft()) {
        return Left(ServerFailure(message: LocaleKeys.noImageSelected));
      }

      final file = result.getOrElse(() => File(""));
      if (file == File("") || file.path.isEmpty) {
        return Left(ServerFailure(message: LocaleKeys.noImageFound));
      }

      // upload
      final url = await storageService.uploadFile(file: file);
      if (url.isEmpty) {
        return Left(ServerFailure(message: LocaleKeys.uploadImageFailed));
      }

      // update DB
      await dataBaseService.updateData(
        collectionKey: BackendEndpoints.usersCollectionName,
        field: "profilePicurl",
        data: url,
        doc: uid,
      );
      await authRepo.fetchUserAndStoreLocally(uid: uid);
      return const Right(null);
    } on CustomException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: LocaleKeys.errorOccurredMessage));
    }
  }
}

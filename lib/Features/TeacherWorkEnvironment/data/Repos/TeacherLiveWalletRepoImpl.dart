// ignore_for_file: file_names

import 'dart:async';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:sintir/Core/entities/FireStoreEntities/FireStoreRequirmentsEntity.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Core/services/RealtimeDataBaseService.dart';
import 'package:sintir/Core/utils/Backend_EndPoints.dart';
import 'package:sintir/Features/Auth/Data/models/TeacherWalletModel.dart';
import 'package:sintir/Features/Auth/Domain/Entities/TeacherWalletEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Repos/TeacherLiveWalletRepo.dart';
import 'package:sintir/locale_keys.dart';

typedef WalletResult = Either<Failure, TeacherWalletEntity>;

class TeacherLiveWalletRepoImpl implements TeacherLiveWalletRepo {
  TeacherLiveWalletRepoImpl({required this.realtimeDataBaseService});

  final RealtimeDataBaseService realtimeDataBaseService;

  static const String _teacherExtraDataKey = 'teacherExtraData';
  static const String _walletKey = 'wallet';

  @override
  Stream<WalletResult> watchWallet({required String teacherId}) {
    return realtimeDataBaseService
        .watchDocument(
          requirements: FireStoreRequirmentsEntity(
            collection: BackendEndpoints.usersCollectionName,
            docId: teacherId,
          ),
        )
        .transform(
          StreamTransformer<Map<String, dynamic>?, WalletResult>.fromHandlers(
            handleData: (user, sink) => sink.add(walletFromUserDocument(user)),
            handleError: (error, stackTrace, sink) {
              log(
                'Live wallet listener failed',
                name: 'TeacherLiveWalletRepo',
                error: error,
                stackTrace: stackTrace,
              );
              sink.add(
                Left(ServerFailure(message: LocaleKeys.errorOccurredMessage)),
              );
            },
          ),
        )
        .distinct();
  }

  static WalletResult walletFromUserDocument(Map<String, dynamic>? user) {
    if (user == null) {
      return Left(ServerFailure(message: LocaleKeys.walletNotFoundError));
    }
    final extraData = user[_teacherExtraDataKey];
    final wallet = extraData is Map ? extraData[_walletKey] : null;
    if (wallet is! Map) {
      return Left(ServerFailure(message: LocaleKeys.walletNotFoundError));
    }
    if (wallet.isEmpty) {
      return Left(ServerFailure(message: LocaleKeys.walletDocumentEmptyError));
    }
    try {
      return Right(
        TeacherWalletModel.fromJson(
          Map<String, dynamic>.from(wallet),
        ).toEntity(),
      );
    } catch (error, stackTrace) {
      log(
        'Malformed wallet data',
        name: 'TeacherLiveWalletRepo',
        error: error,
        stackTrace: stackTrace,
      );
      return Left(ServerFailure(message: LocaleKeys.errorOccurredMessage));
    }
  }
}

import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sintir/Core/entities/FireStoreEntities/FireStoreRequirmentsEntity.dart';
import 'package:sintir/Core/errors/Exceptioons.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Core/services/DataBaseService.dart';
import 'package:sintir/Core/services/PickerAssetsService.dart';
import 'package:sintir/Core/services/StorageService.dart';
import 'package:sintir/Core/utils/Backend_EndPoints.dart';
import 'package:sintir/Core/utils/SupabaseBuckets.dart';
import 'package:sintir/Features/Support/Data/Models/SupportChatMessageModel.dart';
import 'package:sintir/Features/Support/Domain/Entities/SupportChatMessageEntity.dart';
import 'package:sintir/Features/Support/Domain/Repos/SupportChatRepo.dart';
import 'package:sintir/locale_keys.dart';

class SupportChatRepoImpl implements SupportChatRepo {
  final DataBaseService dataBaseService;
  final PickerAssetsService pickerassetsservice;
  final StorageService storageService;
  SupportChatRepoImpl(
      {required this.dataBaseService,
      required this.pickerassetsservice,
      required this.storageService});

  @override
  Future<Either<Failure, void>> removeMessage(
      {required String messageId, required String ticketId}) async {
    try {
      await dataBaseService.deleteDoc(
          collectionKey: BackendEndpoints.supportTicketsCollection,
          docId: ticketId,
          subCollectionKey: BackendEndpoints.supportTicketMessagesSubCollection,
          subDocId: messageId);
      return right(
        null,
      );
    } on CustomException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: LocaleKeys.errorOccurredMessage));
    }
  }

  @override
  Future<Either<Failure, void>> sendMessage(
      {required SupportChatMessageEntity message,
      required String ticketId}) async {
    try {
      Map<String, dynamic> json =
          SupportChatMessageModel.fromEntity(message).toJson();
      await dataBaseService.setData(
          requirements: FireStoreRequirmentsEntity(
              collection: BackendEndpoints.supportTicketsCollection,
              docId: ticketId,
              subCollection:
                  BackendEndpoints.supportTicketMessagesSubCollection,
              subDocId: message.id),
          data: json);
      return right(null);
    } on CustomException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: LocaleKeys.errorOccurredMessage));
    }
  }

  @override
  Future<Either<Failure, void>> updateMessageContent(
      {required String newMessageContent,
      required String ticketId,
      String? iamgeUrl,
      required String messageId}) async {
    try {
      await dataBaseService.updateData(
          requirements: FireStoreRequirmentsEntity(
              collection: BackendEndpoints.supportTicketsCollection,
              docId: ticketId,
              subCollection:
                  BackendEndpoints.supportTicketMessagesSubCollection,
              subDocId: messageId),
          field: "message",
          data: newMessageContent);
      if (iamgeUrl != null && iamgeUrl.isNotEmpty) {
        await dataBaseService.updateData(
            requirements: FireStoreRequirmentsEntity(
                collection: BackendEndpoints.supportTicketsCollection,
                docId: ticketId,
                subCollection:
                    BackendEndpoints.supportTicketMessagesSubCollection,
                subDocId: messageId),
            field: "image",
            data: iamgeUrl);
      }
      return right(null);
    } on CustomException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: LocaleKeys.errorOccurredMessage));
    }
  }

  @override
  Future<Either<Failure, String>> pickAndUplaodImage() async {
    try {
      File? file = await pickerassetsservice.getImage(
        source: ImageSource.gallery,
      );
      if (file == null) {
        return Left(ServerFailure(message: LocaleKeys.imageNotFound));
      }
      String url = await storageService.uploadFile(
          file: file, bucketname: SupabaseBuckets.Support.name);

      return right(url);
    } on CustomException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: LocaleKeys.errorOccurredMessage));
    }
  }
}

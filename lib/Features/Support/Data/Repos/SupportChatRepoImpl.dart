import 'package:dartz/dartz.dart';
import 'package:sintir/Core/entities/FireStoreEntities/FireStoreRequirmentsEntity.dart';
import 'package:sintir/Core/errors/Exceptioons.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Core/services/DataBaseService.dart';
import 'package:sintir/Core/utils/Backend_EndPoints.dart';
import 'package:sintir/Features/Support/Data/Models/SupportChatMessageModel.dart';
import 'package:sintir/Features/Support/Domain/Entities/SupportChatMessageEntity.dart';
import 'package:sintir/Features/Support/Domain/Repos/SupportChatRepo.dart';
import 'package:sintir/locale_keys.dart';

class SupportChatRepoImpl implements SupportChatRepo {
  final DataBaseService dataBaseService;

  SupportChatRepoImpl({required this.dataBaseService});

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
      return right(null);
    } on CustomException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: LocaleKeys.errorOccurredMessage));
    }
  }
}

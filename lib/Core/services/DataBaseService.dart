// ignore_for_file: file_names

import 'package:sintir/Core/entities/FireStorePaginateResponse.dart';
import 'package:sintir/Core/entities/FireStoreRequirmentsEntity.dart';

abstract class Databaseservice {
  Future<void> setData({
    required Map<String, dynamic> data,
    required FireStoreRequirmentsEntity requirements,
  });
  Future<FireStoreResponse> getData(
      {required FireStoreRequirmentsEntity requirements,
      Map<String, dynamic>? query});
  Future<bool> isDataExists(
      {required String key,
      required String docId,
      String? subCollectionKey,
      String? subDocId});
  Future<bool> isFeildExists(
      {required String key, required String feild, required String feildValue});

  Future<void> updateData(
      {required String collectionKey,
      required doc,
      required dynamic data,
      required String field,
      String? subCollectionKey,
      String? subDocId});
  Future<void> deleteDoc(
      {required String collectionKey,
      required String docId,
      String? subCollectionKey,
      String? subDocId});
}

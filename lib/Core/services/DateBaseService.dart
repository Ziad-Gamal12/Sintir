// ignore_for_file: file_names

abstract class Datebaseservice {
  Future<void> setData({
    required Map<String, dynamic> data,
    required Map<String, dynamic>? json,
  });
  Future getData(
      {String? subCollectionKey,
      String? subDocId,
      required String key,
      String? docId,
      String? subCollection2Key,
      String? sub2DocId,
      Map<String, dynamic>? query});
  Future<bool> isDataExists(
      {required String key,
      required String docId,
      String? subCollectionKey,
      String? subDocId});
  Future<bool> isFeildExists(
      {required String key, required String feild, required String feildValue});

  Future<void> updateDate(
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

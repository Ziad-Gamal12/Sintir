// ignore_for_file: file_names

abstract class Datebaseservice {
  Future<void> setData(
      {required String key,
      required Map<String, dynamic> data,
      String? subCollectionKey,
      String? subDocId,
      String? docId});
  Future getData(
      {required String key, String? docId, Map<String, dynamic>? query});
  Future<bool> isDataExists({required String key, required String docId});
  Future<bool> isFeildExists(
      {required String key, required String feild, required String feildValue});
}

abstract class Datebaseservice {
  Future<void> setData(
      {required String key,
      required Map<String, dynamic> data,
      required String docId});
  Future<Map<String, dynamic>> getData(
      {required String key, required String docId});
  Future<bool> isDataExists({required String key, required String docId});
}

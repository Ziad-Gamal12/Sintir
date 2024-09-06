import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fruits/core/Utils/Backend_EndPoints.dart';
import 'package:fruits/core/services/DateBaseService.dart';

class FirebaseFirestoreservice implements Datebaseservice {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  Future<void> setData(
      {required String key,
      required Map<String, dynamic> data,
      required String docId}) async {
    await firestore.collection(key).doc(docId).set(data);
  }

  @override
  Future<Map<String, dynamic>> getData(
      {required String key, required String docId}) async {
    var userEntity = await firestore
        .collection(BackendEndpoints.addUserPath)
        .doc(docId)
        .get();
    return userEntity.data() as Map<String, dynamic>;
  }

  @override
  Future<bool> isDataExists(
      {required String key, required String docId}) async {
    var isExists = await firestore.collection(key).doc(docId).get();
    return isExists.exists;
  }
}

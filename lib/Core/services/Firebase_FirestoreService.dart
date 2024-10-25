// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sintir/Core/services/DateBaseService.dart';

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
  Future getData({required String key, required String docId}) async {
    var userEntity = await firestore.collection(key).doc(docId).get();

    return userEntity.data();
  }

  @override
  Future<bool> isDataExists(
      {required String key, required String docId}) async {
    var isExists = await firestore.collection(key).doc(docId).get();
    return isExists.exists;
  }

  @override
  Future<bool> isFeildExists(
      {required String key,
      required String feild,
      required String feildValue}) async {
    QuerySnapshot<Map<String, dynamic>> fileds = await firestore
        .collection(key)
        .where(feild, isEqualTo: feildValue)
        .get();
    return fileds.docs.isEmpty ? false : true;
  }
}

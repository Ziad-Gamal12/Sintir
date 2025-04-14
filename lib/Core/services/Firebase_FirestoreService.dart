// ignore_for_file: file_names

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sintir/Core/errors/Exceptioons.dart';
import 'package:sintir/Core/services/DateBaseService.dart';

class FirebaseFirestoreservice implements Datebaseservice {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  Future<void> setData(
      {required String key,
      required Map<String, dynamic> data,
      String? subCollectionKey,
      String? subDocId,
      String? subCollection2Key,
      String? sub2DocId,
      String? docId}) async {
    try {
      if (subCollectionKey != null) {
        if (subDocId != null) {
          if (subCollection2Key != null) {
            if (sub2DocId != null) {
              await firestore
                  .collection(key)
                  .doc(docId)
                  .collection(subCollectionKey)
                  .doc(subDocId)
                  .collection(subCollection2Key)
                  .doc(sub2DocId)
                  .set(data);
            } else {
              await firestore
                  .collection(key)
                  .doc(docId)
                  .collection(subCollectionKey)
                  .doc(subDocId)
                  .collection(subCollection2Key)
                  .add(data);
            }
          } else {
            await firestore
                .collection(key)
                .doc(docId)
                .collection(subCollectionKey)
                .doc(subDocId)
                .set(data);
          }
        } else {
          await firestore
              .collection(key)
              .doc(docId)
              .collection(subCollectionKey)
              .add(data);
        }
      } else {
        if (docId != null) {
          await firestore.collection(key).doc(docId).set(data);
        } else {
          await firestore.collection(key).add(data);
        }
      }
    } on FirebaseException catch (e) {
      if (e.code == 'permission-denied') {
        throw CustomException(
            message:
                "🚨 ليس لديك الإذن اللازم لإضافة البيانات. يرجى مراجعة صلاحياتك أو تعديل قواعد الأمان في Firestore.");
      } else if (e.code == "unavailable") {
        throw CustomException(
            message: "🚨 الخادم غير متوفر حاليا. يرجى المحاولة لاحقا.");
      } else if (e.code == "invalid-argument") {
        throw CustomException(
            message:
                "❌ تم تمرير بيانات غير صحيحة. يرجى التحقق من المدخلات وإعادة المحاولة.");
      } else if (e.code == "deadline-exceeded") {
        throw CustomException(
            message:
                "⏳ انتهت المهلة الزمنية للطلب. يرجى المحاولة مرة أخرى لاحقًا.");
      } else if (e.code == "resource-exhausted") {
        throw CustomException(
            message: "🚨 استهلاك الحافزات المتاحة. يرجى المحاولة لاحقًا.");
      }
    }
  }

  @override
  Future getData(
      {String? subCollectionKey,
      String? subDocId,
      required String key,
      String? docId,
      Map<String, dynamic>? query}) async {
    try {
      if (docId != null) {
        var userEntity = firestore.collection(key).doc(docId);
        if (subCollectionKey != null) {
          var result = userEntity.collection(subCollectionKey);
          if (subDocId != null) {
            var docresult = result.doc(subDocId);
            return docresult.get();
          }
          return await result
              .get()
              .then((e) => e.docs.map((e) => e.data()).toList());
        } else {
          var result = await userEntity.get();
          return result.data() as Map<String, dynamic>;
        }
      } else {
        Query queryData = firestore.collection(key);
        if (query != null) {
          if (query["isFree"] != null) {
            queryData = queryData.where("price", isEqualTo: 0);
          }
          if (query["state"] != null) {
            queryData = queryData.where("state", isEqualTo: query["state"]);
          }
          if (query["id"] != null) {
            queryData = queryData.where("id", isEqualTo: query["id"]);
          }
          if (query["title"] != null) {
            queryData = queryData.where("title", isEqualTo: query["title"]);
          }
          if (query["language"] != null) {
            queryData =
                queryData.where("language", isEqualTo: query["language"]);
          }
          if (query["limit"] != null) {
            queryData = queryData.limit(query["limit"]);
          }
          if (query["orderBy"] != null) {
            queryData = queryData.orderBy(query["orderBy"], descending: true);
          }
        }

        var result = await queryData.get();
        return result.docs.map((e) => e.data()).toList();
      }
    } on FirebaseException catch (e) {
      if (e.code == 'permission-denied') {
        throw CustomException(
            message:
                "🚨 ليس لديك الإذن اللازم لإضافة البيانات. يرجى مراجعة صلاحياتك أو تعديل قواعد الأمان في Firestore.");
      } else if (e.code == "unavailable") {
        throw CustomException(
            message: "🚨 الخادم غير متوفر حاليا. يرجى المحاولة لاحقا.");
      } else if (e.code == "invalid-argument") {
        throw CustomException(
            message:
                "❌ تم تمرير بيانات غير صحيحة. يرجى التحقق من المدخلات وإعادة المحاولة.");
      } else if (e.code == "deadline-exceeded") {
        throw CustomException(
            message:
                "⏳ انتهت المهلة الزمنية للطلب. يرجى المحاولة مرة أخرى لاحقًا.");
      } else if (e.code == "resource-exhausted") {
        throw CustomException(
            message: "🚨 استهلاك الحافزات المتاحة. يرجى المحاولة لاحقًا.");
      } else {
        throw CustomException(message: "حدث خطأ ما");
      }
    }
  }

  @override
  Future<bool> isDataExists(
      {required String key,
      required String docId,
      String? subCollectionKey,
      String? subDocId}) async {
    if (subCollectionKey != null) {
      var isExists = await firestore
          .collection(key)
          .doc(docId)
          .collection(subCollectionKey)
          .doc(subDocId)
          .get();
      return isExists.exists;
    }
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

  @override
  Future<void> updateDate(
      {required String collectionKey,
      required doc,
      required dynamic data,
      required String field,
      String? subCollectionKey,
      String? subDocId}) async {
    try {
      if (subCollectionKey != null) {
        await firestore
            .collection(collectionKey)
            .doc(doc)
            .collection(subCollectionKey)
            .doc(subDocId)
            .update({field: data});
      } else {
        await firestore
            .collection(collectionKey)
            .doc(doc)
            .update({field: data});
      }
    } on FirebaseException catch (e) {
      if (e.code == 'permission-denied') {
        throw CustomException(
            message:
                "🚨 ليس لديك الإذن اللازم لإضافة البيانات. يرجى مراجعة صلاحياتك أو تعديل قواعد الأمان في Firestore.");
      } else if (e.code == "unavailable") {
        throw CustomException(
            message: "🚨 الخادم غير متوفر حاليا. يرجى المحاولة لاحقا.");
      } else if (e.code == "invalid-argument") {
        throw CustomException(
            message:
                "❌ تم تمرير بيانات غير صحيحة. يرجى التحقق من المدخلات وإعادة المحاولة.");
      } else if (e.code == "deadline-exceeded") {
        throw CustomException(
            message:
                "⏳ انتهت المهلة الزمنية للطلب. يرجى المحاولة مرة أخرى لاحقًا.");
      } else if (e.code == "resource-exhausted") {
        throw CustomException(
            message: "🚨 استهلاك الحافزات المتاحة. يرجى المحاولة لاحقًا.");
      } else {
        throw CustomException(message: "حدث خطأ ما");
      }
    } catch (e) {
      log("Exception from Firebase_FirestoreService.updateDate in catch With Firebase Exception: ${e.toString()}");
      throw CustomException(message: "حدث خطأ ما");
    }
  }

  @override
  Future<void> deleteDoc(
      {required String collectionKey,
      required String docId,
      String? subCollectionKey,
      String? subDocId}) async {
    if (subCollectionKey != null) {
      await firestore
          .collection(collectionKey)
          .doc(docId)
          .collection(subCollectionKey)
          .doc(subDocId)
          .delete();
    }
    await firestore.collection(collectionKey).doc(docId).delete();
  }
}

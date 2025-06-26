// ignore_for_file: file_names

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sintir/Core/entities/FireStoreRequirmentsEntity.dart';
import 'package:sintir/Core/errors/Exceptioons.dart';
import 'package:sintir/Core/services/DataBaseService.dart';

class FirebaseFirestoreservice implements Databaseservice {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  Future<void> setData({
    required Map<String, dynamic> data,
    required FireStoreRequirmentsEntity requirements,
  }) async {
    try {
      if (requirements.collection != null) {
        var query = firestore.collection(requirements.collection!);
        if (requirements.docId != null) {
          if (requirements.subCollection != null) {
            var query1 = query
                .doc(requirements.docId)
                .collection(requirements.subCollection!);
            if (requirements.subDocId != null) {
              if (requirements.subCollection2 != null) {
                var query2 = query1
                    .doc(requirements.subDocId)
                    .collection(requirements.subCollection2!);
                if (requirements.sub2DocId != null) {
                  if (requirements.subCollection3 != null) {
                    var query3 = query2
                        .doc(requirements.sub2DocId)
                        .collection(requirements.subCollection3!);
                    if (requirements.sub3DocId != null) {
                      await query3.doc(requirements.sub3DocId).set(data);
                    } else {
                      await query3.add(data);
                    }
                  } else {
                    await query2.doc(requirements.sub2DocId).set(data);
                  }
                } else {
                  await query2.add(data);
                }
              } else {
                await query1.doc(requirements.subDocId).set(data);
              }
            } else {
              await query1.add(data);
            }
          } else {
            await query.doc(requirements.docId).set(data);
          }
        } else {
          await query.add(data);
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
  Future getData({
    required FireStoreRequirmentsEntity requirements,
    Map<String, dynamic>? query,
  }) async {
    try {
      CollectionReference<Map<String, dynamic>> currentCollection =
          firestore.collection(requirements.collection!);
      if (requirements.docId != null) {
        DocumentReference<Map<String, dynamic>> docRef =
            currentCollection.doc(requirements.docId!);
        if (requirements.subCollection != null) {
          currentCollection = docRef.collection(requirements.subCollection!);
          if (requirements.subDocId != null) {
            DocumentReference<Map<String, dynamic>> subDocRef =
                currentCollection.doc(requirements.subDocId!);

            if (requirements.subCollection2 != null) {
              currentCollection =
                  subDocRef.collection(requirements.subCollection2!);

              if (requirements.sub2DocId != null) {
                DocumentReference<Map<String, dynamic>> sub2DocRef =
                    currentCollection.doc(requirements.sub2DocId!);

                if (requirements.subCollection3 != null) {
                  currentCollection =
                      sub2DocRef.collection(requirements.subCollection3!);

                  if (requirements.sub3DocId != null) {
                    DocumentReference<Map<String, dynamic>> sub3DocRef =
                        currentCollection.doc(requirements.sub3DocId!);

                    if (requirements.subCollection4 != null) {
                      currentCollection =
                          sub3DocRef.collection(requirements.subCollection4!);

                      if (requirements.sub4DocId != null) {
                        final sub4DocRef =
                            currentCollection.doc(requirements.sub4DocId!);
                        final sub4DocSnapshot = await sub4DocRef.get();
                        return sub4DocSnapshot.data();
                      } else {
                        final sub4Snapshot = await currentCollection.get();
                        return sub4Snapshot.docs.map((e) => e.data()).toList();
                      }
                    } else {
                      final sub3DocSnapshot = await sub3DocRef.get();
                      return sub3DocSnapshot.data();
                    }
                  } else {
                    final sub3Snapshot = await currentCollection.get();
                    return sub3Snapshot.docs.map((e) => e.data()).toList();
                  }
                } else {
                  final sub2DocSnapshot = await sub2DocRef.get();
                  return sub2DocSnapshot.data();
                }
              } else {
                final sub2Snapshot = await currentCollection.get();
                return sub2Snapshot.docs.map((e) => e.data()).toList();
              }
            } else {
              final subDocSnapshot = await subDocRef.get();
              return subDocSnapshot.data();
            }
          } else {
            final subSnapshot = await currentCollection.get();
            return subSnapshot.docs.map((e) => e.data()).toList();
          }
        } else {
          final docSnapshot = await docRef.get();
          return docSnapshot.data();
        }
      } else {
        Query queryData = currentCollection;
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

        final querySnapshot = await queryData.get();
        return querySnapshot.docs.map((e) => e.data()).toList();
      }
    } on FirebaseException catch (e) {
      switch (e.code) {
        case 'permission-denied':
          throw CustomException(
            message:
                "🚨 ليس لديك الإذن اللازم للوصول إلى البيانات. يرجى مراجعة صلاحياتك.",
          );
        case 'unavailable':
          throw CustomException(
            message: "🚨 الخادم غير متوفر حاليا. حاول مرة أخرى لاحقا.",
          );
        case 'invalid-argument':
          throw CustomException(
            message:
                "❌ تم تمرير بيانات غير صحيحة. تأكد من المدخلات وحاول مجددًا.",
          );
        case 'deadline-exceeded':
          throw CustomException(
            message: "⏳ انتهت المهلة الزمنية للطلب. حاول مرة أخرى.",
          );
        case 'resource-exhausted':
          throw CustomException(
            message: "🚨 تم استهلاك الموارد المتاحة. يرجى المحاولة لاحقًا.",
          );
        default:
          throw CustomException(message: "❌ حدث خطأ غير متوقع.");
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

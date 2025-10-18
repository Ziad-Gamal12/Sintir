// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sintir/Core/entities/FireStorePaginateResponse.dart';
import 'package:sintir/Core/entities/FireStoreRequirmentsEntity.dart';
import 'package:sintir/Core/errors/Exceptioons.dart';
import 'package:sintir/Core/services/DataBaseService.dart';

class FirebaseFirestoreservice implements Databaseservice {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> _collectionRef(String collection) =>
      firestore.collection(collection);

  Query<Map<String, dynamic>> _applyQueryOptions(
    Query<Map<String, dynamic>> base,
    Map<String, dynamic>? options,
  ) {
    Query<Map<String, dynamic>> query = base;

    if (options == null) return query;

    if (options["filters"] is List<Map<String, dynamic>>) {
      for (final Map<String, dynamic> f in options["filters"]) {
        final field = f["field"];
        final value = f["value"];
        final operator = f["operator"];
        if (field == null || value == null) continue;

        if (operator == null || operator == "==") {
          query = query.where(field, isEqualTo: value);
        } else if (operator == ">=") {
          query = query.where(field, isGreaterThanOrEqualTo: value);
        } else if (operator == "<=") {
          query = query.where(field, isLessThanOrEqualTo: value);
        } else if (operator == "<") {
          query = query.where(field, isLessThan: value);
        } else if (operator == ">") {
          query = query.where(field, isGreaterThan: value);
        } else if (operator == "!=") {
          query = query.where(field, isNotEqualTo: value);
        }
      }
    }
    if (options["searchField"] is String && options["searchValue"] != null) {
      query = query.where(
        options["searchField"],
        isGreaterThanOrEqualTo: options["searchValue"],
        isLessThan: "${options["searchValue"]}\uf8ff",
      );
    }

    if (options["orderBy"] != null) {
      query = query.orderBy(
        options["orderBy"],
        descending: options["descending"] ?? true,
      );
      if (options["startAt"] != null) query = query.startAt(options["startAt"]);
      if (options["endAt"] != null) query = query.endAt(options["endAt"]);
    }

    if (options["limit"] != null) query = query.limit(options["limit"]);
    if (options["startAfter"] != null) {
      query = query.startAfterDocument(options["startAfter"]);
    }

    return query;
  }

  Exception _getFireStoreCustomException({required FirebaseException e}) {
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

  @override
  Future<void> setData({
    required Map<String, dynamic> data,
    required FireStoreRequirmentsEntity requirements,
  }) async {
    try {
      if (requirements.collection == null) return;

      CollectionReference<Map<String, dynamic>> query =
          _collectionRef(requirements.collection!);

      if (requirements.docId == null) {
        await query.add(data);
        return;
      }
      if (requirements.subCollection == null) {
        await _collectionRef(
          requirements.collection!,
        ).doc(requirements.docId!).set(data);
        return;
      }

      var q1 = _collectionRef(
        requirements.collection!,
      ).doc(requirements.docId!).collection(requirements.subCollection!);

      if (requirements.subDocId == null) {
        await q1.add(data);
        return;
      }

      if (requirements.subCollection2 == null) {
        await q1.doc(requirements.subDocId!).set(data);
        return;
      }

      var q2 = q1
          .doc(requirements.subDocId!)
          .collection(requirements.subCollection2!);

      if (requirements.sub2DocId == null) {
        await q2.add(data);
        return;
      }

      if (requirements.subCollection3 == null) {
        await q2.doc(requirements.sub2DocId!).set(data);
        return;
      }

      var q3 = q2
          .doc(requirements.sub2DocId!)
          .collection(requirements.subCollection3!);

      // sub3DocId
      if (requirements.sub3DocId == null) {
        await q3.add(data);
      } else {
        await q3.doc(requirements.sub3DocId!).set(data);
      }
    } on FirebaseException catch (e) {
      throw _getFireStoreCustomException(e: e);
    }
  }

  @override
  Future<FireStoreResponse> getData({
    required FireStoreRequirmentsEntity requirements,
    Map<String, dynamic>? query,
  }) async {
    try {
      if (requirements.collection == null) {
        return FireStoreResponse();
      }

      CollectionReference<Map<String, dynamic>> currentCollection =
          _collectionRef(requirements.collection!);
      DocumentReference<Map<String, dynamic>>? currentDoc;

      final subLevels = [
        {
          "subCollection": requirements.subCollection,
          "docId": requirements.subDocId
        },
        {
          "subCollection": requirements.subCollection2,
          "docId": requirements.sub2DocId
        },
        {
          "subCollection": requirements.subCollection3,
          "docId": requirements.sub3DocId
        },
        {
          "subCollection": requirements.subCollection4,
          "docId": requirements.sub4DocId
        },
      ];

      if (requirements.docId != null) {
        currentDoc = currentCollection.doc(requirements.docId!);

        for (final level in subLevels) {
          if (level["subCollection"] != null) {
            currentCollection =
                currentDoc!.collection(level["subCollection"] as String);

            if (level["docId"] != null) {
              currentDoc = currentCollection.doc(level["docId"] as String);
            } else {
              Query<Map<String, dynamic>> queryData =
                  _applyQueryOptions(currentCollection, query);
              final snapshot = await queryData.get();
              return FireStoreResponse(
                hasMore: snapshot.docs.length == query?["limit"],
                lastDocumentSnapshot:
                    snapshot.docs.isNotEmpty ? snapshot.docs.last : null,
                listData: snapshot.docs.map((e) => e.data()).toList(),
              );
            }
          }
        }

        final finalDocSnap = await currentDoc!.get();
        return FireStoreResponse(docData: finalDocSnap.data());
      }
      Query<Map<String, dynamic>> queryData =
          _applyQueryOptions(currentCollection, query);
      final querySnapshot = await queryData.get();
      return FireStoreResponse(
        hasMore: querySnapshot.docs.length == query?["limit"],
        lastDocumentSnapshot:
            querySnapshot.docs.isNotEmpty ? querySnapshot.docs.last : null,
        listData: querySnapshot.docs.map((e) => e.data()).toList(),
      );
    } on FirebaseException catch (e) {
      throw _getFireStoreCustomException(e: e);
    } catch (e) {
      throw CustomException(message: "❌ حدث خطأ غير متوقع.");
    }
  }

  @override
  Future<bool> isDataExists({
    required String key,
    required String docId,
    String? subCollectionKey,
    String? subDocId,
  }) async {
    if (subCollectionKey != null) {
      final snapshot = await firestore
          .collection(key)
          .doc(docId)
          .collection(subCollectionKey)
          .doc(subDocId)
          .get();
      return snapshot.exists;
    }

    final snapshot = await firestore.collection(key).doc(docId).get();
    return snapshot.exists;
  }

  @override
  Future<bool> isFeildExists({
    required String key,
    required String feild,
    required String feildValue,
  }) async {
    final fileds = await firestore
        .collection(key)
        .where(feild, isEqualTo: feildValue)
        .get();
    return fileds.docs.isNotEmpty;
  }

  @override
  Future<void> updateData({
    required String collectionKey,
    required doc,
    required dynamic data,
    String? field,
    String? subCollectionKey,
    String? subDocId,
  }) async {
    try {
      if (subCollectionKey != null) {
        final target = firestore
            .collection(collectionKey)
            .doc(doc)
            .collection(subCollectionKey)
            .doc(subDocId);

        if (field == null) {
          await target.update(data);
        } else {
          await target.update({field: data});
        }
      } else {
        final target = firestore.collection(collectionKey).doc(doc);
        if (field == null) {
          await target.update(data);
        } else {
          await target.update({field: data});
        }
      }
    } on FirebaseException catch (e) {
      throw _getFireStoreCustomException(e: e);
    } catch (e) {
      throw CustomException(message: "حدث خطأ ما");
    }
  }

  @override
  Future<void> deleteDoc(
      {required String collectionKey,
      required String docId,
      String? subCollectionKey,
      String? subDocId}) async {
    try {
      if (subCollectionKey != null) {
        await firestore
            .collection(collectionKey)
            .doc(docId)
            .collection(subCollectionKey)
            .doc(subDocId)
            .delete();
      } else {
        await firestore.collection(collectionKey).doc(docId).delete();
      }
    } on FirebaseException catch (e) {
      throw _getFireStoreCustomException(e: e);
    } catch (e) {
      throw CustomException(message: "حدث خطأ ما");
    }
  }

  @override
  Future<int> getCollectionItemsCount({
    required FireStoreRequirmentsEntity requirements,
    Map<String, dynamic>? query,
  }) async {
    try {
      if (requirements.collection == null) {
        return 0;
      }
      List<Map<String, String?>> levels = [
        {
          "subCollection": requirements.subCollection,
          "docId": requirements.subDocId
        },
        {
          "subCollection": requirements.subCollection2,
          "docId": requirements.sub2DocId
        },
        {
          "subCollection": requirements.subCollection3,
          "docId": requirements.sub3DocId
        },
        {
          "subCollection": requirements.subCollection4,
          "docId": requirements.sub4DocId
        },
      ];
      CollectionReference<Map<String, dynamic>> currentCollection =
          _collectionRef(requirements.collection!);
      if (requirements.docId == null && query != null) {
        Query<Map<String, dynamic>> queryResult =
            _applyQueryOptions(currentCollection, query);
        final querySnapshot = await queryResult.get();
        return querySnapshot.docs.length;
      } else if (requirements.docId == null && query == null) {
        final querySnapshot = await currentCollection.get();
        return querySnapshot.docs.length;
      }
      DocumentReference<Map<String, dynamic>> currentDoc =
          currentCollection.doc(requirements.docId!);

      for (Map<String, String?> level in levels) {
        if (level["subCollection"] != null) {
          currentCollection =
              currentDoc.collection(level["subCollection"] as String);
          if (level["docId"] != null) {
            currentDoc = currentCollection.doc(level["docId"] as String);
          }
        } else {
          break;
        }
      }
      if (query != null) {
        Query<Map<String, dynamic>> queryResult =
            _applyQueryOptions(currentCollection, query);
        final querySnapshot = await queryResult.get();
        return querySnapshot.docs.length;
      } else {
        final querySnapshot = await currentCollection.get();
        return querySnapshot.docs.length;
      }
    } on FirebaseException catch (e) {
      throw _getFireStoreCustomException(e: e);
    } catch (e) {
      throw CustomException(message: "حدث خطأ ما");
    }
  }
}

// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sintir/Core/entities/FireStoreEntities/FireStorePaginateResponse.dart';
import 'package:sintir/Core/entities/FireStoreEntities/FireStoreRequirmentsEntity.dart';
import 'package:sintir/Core/errors/Exceptioons.dart';
import 'package:sintir/Core/services/DataBaseService.dart';
import 'package:sintir/Core/services/NetworkStatus.dart';
import 'package:sintir/Core/services/RealtimeDataBaseService.dart';
import 'package:sintir/locale_keys.dart';

class FirebaseFirestoreservice
    implements DataBaseService, RealtimeDataBaseService {
  FirebaseFirestoreservice({FirebaseFirestore? firestore, NetworkStatus? network})
      : firestore = firestore ?? FirebaseFirestore.instance,
        _network = network;

  FirebaseFirestore firestore;
  final NetworkStatus? _network;

  NetworkStatus get network => _network ?? NetworkStatus.current;

  GetOptions get readOptions => GetOptions(
        source: network.isOnline ? Source.serverAndCache : Source.cache,
      );

  void requireOnline() {
    if (!network.isOnline) {
      throw CustomException(message: LocaleKeys.noInternet);
    }
  }

  static bool isEmptyResponse(FireStoreResponse response) =>
      response.docData == null &&
      (response.listData == null || response.listData!.isEmpty);

  @override
  Stream<Map<String, dynamic>?> watchDocument({
    required FireStoreRequirmentsEntity requirements,
  }) {
    try {
      // Metadata-only changes (pending writes, cache → server) are skipped,
      // so listeners only wake up when the document's data changes.
      return _resolveUpdateTarget(
        requirements,
      ).snapshots().map((snapshot) => snapshot.data());
    } catch (error, stackTrace) {
      // Invalid paths throw synchronously; surface them on the stream so
      // every failure reaches the caller the same way.
      return Stream.error(error, stackTrace);
    }
  }

  CollectionReference<Map<String, dynamic>> _collectionRef(String collection) =>
      firestore.collection(collection);

  Query<Map<String, dynamic>> _applyQueryOptions(
    Query<Map<String, dynamic>> base,
    Map<String, dynamic>? options,
  ) {
    Query<Map<String, dynamic>> query = base;

    if (options == null) return query;

    // 🔹 Apply filters
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

    // 🔹 Apply search filter (startAt / endAt for prefix search)
    if (options["searchField"] is String && options["searchValue"] != null) {
      query = query.where(
        options["searchField"],
        isGreaterThanOrEqualTo: options["searchValue"],
        isLessThan: "${options["searchValue"]}\uf8ff",
      );
    }

    // 🔹 Apply ordering (supports one OR multiple)
    if (options["orderBy"] != null) {
      final orderBy = options["orderBy"];
      final descending = options["descending"];

      if (orderBy is List<Map<String, dynamic>>) {
        // Multiple fields sorting
        for (int i = 0; i < orderBy.length; i++) {
          final field = orderBy[i]["field"];
          final isDesc = orderBy[i]["descending"] ?? true;
          query = query.orderBy(field, descending: isDesc);
        }
      } else if (orderBy is String) {
        // Single field sorting
        query = query.orderBy(orderBy, descending: descending ?? true);
      }

      // Optional startAt / endAt
      if (options["startAt"] != null) query = query.startAt(options["startAt"]);
      if (options["endAt"] != null) query = query.endAt(options["endAt"]);
    }

    // 🔹 Apply limit and pagination
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
          message: LocaleKeys.permissionDenied,
        );
      case 'unavailable':
        throw CustomException(
          message: network.isOnline
              ? LocaleKeys.serverUnavailable
              : LocaleKeys.noInternet,
        );
      case 'invalid-argument':
        throw CustomException(
          message: LocaleKeys.invalidArgument,
        );
      case 'deadline-exceeded':
        throw CustomException(
          message: network.isOnline
              ? LocaleKeys.deadlineExceeded
              : LocaleKeys.noInternet,
        );
      case 'resource-exhausted':
        throw CustomException(
          message: LocaleKeys.resourceExhausted,
        );
      default:
        throw CustomException(message: LocaleKeys.unexpectedError);
    }
  }

  @override
  Future<void> setData({
    required Map<String, dynamic> data,
    required FireStoreRequirmentsEntity requirements,
  }) async {
    requireOnline();
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
    final response = await _readData(requirements: requirements, query: query);
    if (!network.isOnline && isEmptyResponse(response)) {
      throw CustomException(message: LocaleKeys.noInternet);
    }
    return response;
  }

  Future<FireStoreResponse> _readData({
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
              final snapshot = await queryData.get(readOptions);
              return FireStoreResponse(
                hasMore: snapshot.docs.length == query?["limit"],
                lastDocumentSnapshot:
                    snapshot.docs.isNotEmpty ? snapshot.docs.last : null,
                listData: snapshot.docs.map((e) => e.data()).toList(),
              );
            }
          }
        }

        final finalDocSnap = await currentDoc!.get(readOptions);
        return FireStoreResponse(docData: finalDocSnap.data());
      }
      Query<Map<String, dynamic>> queryData =
          _applyQueryOptions(currentCollection, query);
      final querySnapshot = await queryData.get(readOptions);
      return FireStoreResponse(
        hasMore: querySnapshot.docs.length == query?["limit"],
        lastDocumentSnapshot:
            querySnapshot.docs.isNotEmpty ? querySnapshot.docs.last : null,
        listData: querySnapshot.docs.map((e) => e.data()).toList(),
      );
    } on FirebaseException catch (e) {
      throw _getFireStoreCustomException(e: e);
    } on CustomException {
      rethrow;
    } catch (e) {
      throw CustomException(message: LocaleKeys.unexpectedError);
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
          .get(readOptions);
      return snapshot.exists;
    }

    final snapshot =
        await firestore.collection(key).doc(docId).get(readOptions);
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
        .get(readOptions);
    return fileds.docs.isNotEmpty;
  }

  @override
  Future<void> updateData({
    required dynamic data,
    required FireStoreRequirmentsEntity requirements,
    String? field,
  }) async {
    requireOnline();
    try {
      DocumentReference<Map<String, dynamic>> target =
          _resolveUpdateTarget(requirements);

      final Map<String, dynamic> updatePayload =
          (field == null) ? data as Map<String, dynamic> : {field: data};
      await target.update(updatePayload);
    } on FirebaseException catch (e) {
      throw _getFireStoreCustomException(e: e);
    } catch (e) {
      throw CustomException(message: LocaleKeys.errorOccurredMessage);
    }
  }

  DocumentReference<Map<String, dynamic>> _resolveUpdateTarget(
      FireStoreRequirmentsEntity req) {
    if (req.collection == null || req.docId == null) {
      throw Exception("Cannot update without collection and docId");
    }

    var ref = firestore.collection(req.collection!).doc(req.docId!);

    if (req.subCollection != null && req.subDocId != null) {
      ref = ref.collection(req.subCollection!).doc(req.subDocId!);

      if (req.subCollection2 != null && req.sub2DocId != null) {
        ref = ref.collection(req.subCollection2!).doc(req.sub2DocId!);

        if (req.subCollection3 != null && req.sub3DocId != null) {
          ref = ref.collection(req.subCollection3!).doc(req.sub3DocId!);
        }
      }
    }

    return ref;
  }

  @override
  Future<void> deleteDoc(
      {required String collectionKey,
      required String docId,
      String? subCollectionKey,
      String? subCollectionKey2,
      String? subDocId2,
      String? subDocId}) async {
    requireOnline();
    try {
      if (subCollectionKey != null) {
        if (subCollectionKey2 != null) {
          await firestore
              .collection(collectionKey)
              .doc(docId)
              .collection(subCollectionKey)
              .doc(subDocId)
              .collection(subCollectionKey2)
              .doc(subDocId2)
              .delete();
        } else {
          await firestore
              .collection(collectionKey)
              .doc(docId)
              .collection(subCollectionKey)
              .doc(subDocId)
              .delete();
        }
      } else {
        await firestore.collection(collectionKey).doc(docId).delete();
      }
    } on FirebaseException catch (e) {
      throw _getFireStoreCustomException(e: e);
    } catch (e) {
      throw CustomException(message: LocaleKeys.errorOccurredMessage);
    }
  }

  @override
  Future<int> getCollectionItemsCount({
    required FireStoreRequirmentsEntity requirements,
    Map<String, dynamic>? query,
  }) async {
    requireOnline();
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
        final aggregate = await queryResult.count().get();
        return aggregate.count ?? 0;
      } else if (requirements.docId == null && query == null) {
        final aggregate = await currentCollection.count().get();
        return aggregate.count ?? 0;
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
        final aggregate = await queryResult.count().get();
        return aggregate.count ?? 0;
      } else {
        final aggregate = await currentCollection.count().get();
        return aggregate.count ?? 0;
      }
    } on FirebaseException catch (e) {
      throw _getFireStoreCustomException(e: e);
    } catch (e) {
      throw CustomException(message: LocaleKeys.errorOccurredMessage);
    }
  }

  @override
  Future<T> runDocumentTransaction<T>({
    required FireStoreRequirmentsEntity requirements,
    required DocumentTransactionAction<T> action,
  }) async {
    requireOnline();
    try {
      final ref = _resolveUpdateTarget(requirements);

      return await firestore.runTransaction<T>((transaction) async {
        final snapshot = await transaction.get(ref);

        Map<String, dynamic>? pendingUpdate;

        final result = action(
          snapshot.data(),
          (fields) {
            pendingUpdate = {
              ...?pendingUpdate,
              ...fields,
            };
          },
        );

        if (pendingUpdate != null) {
          if (!snapshot.exists) {
            throw StateError(
              'Cannot update a document that does not exist.',
            );
          }

          transaction.update(ref, pendingUpdate!);
        }

        return result;
      });
    } on FirebaseException catch (e) {
      throw _getFireStoreCustomException(e: e);
    }
  }
}

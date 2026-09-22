import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseTypesHelper {
  static dynamic convertFirebaseTypes(dynamic value) {
    if (value is Timestamp) {
      return value.toDate();
    }

    if (value is Map) {
      return <String, dynamic>{
        for (final entry in value.entries)
          entry.key.toString(): convertFirebaseTypes(entry.value),
      };
    }

    if (value is List) {
      return value.map(convertFirebaseTypes).toList();
    }

    return value;
  }

  static DateTime date(dynamic value) {
    if (value is Timestamp) return value.toDate();
    if (value is DateTime) return value;
    if (value is String) {
      return DateTime.tryParse(value) ?? DateTime.fromMillisecondsSinceEpoch(0);
    }
    return DateTime.fromMillisecondsSinceEpoch(0);
  }
}

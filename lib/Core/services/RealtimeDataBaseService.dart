// ignore_for_file: file_names

import 'package:sintir/Core/entities/FireStoreEntities/FireStoreRequirmentsEntity.dart';

abstract interface class RealtimeDataBaseService {
  Stream<Map<String, dynamic>?> watchDocument({
    required FireStoreRequirmentsEntity requirements,
  });
}

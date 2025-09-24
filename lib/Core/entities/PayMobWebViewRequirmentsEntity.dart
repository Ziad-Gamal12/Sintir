import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/entities/PayMobResponse.dart';

class PayMobWebViewRequirmentsEntity {
  final PayMobResponse payMobResponse;
  final CourseEntity course;
  const PayMobWebViewRequirmentsEntity({
    required this.payMobResponse,
    required this.course,
  });
}

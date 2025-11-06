import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Features/Subscribtion/Domain/Entities/PayMobResponse.dart';

class PayMobWebViewRequirmentsEntity {
  final PayMobResponse payMobResponse;
  final CourseEntity course;
  const PayMobWebViewRequirmentsEntity({
    required this.payMobResponse,
    required this.course,
  });
}

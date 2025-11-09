import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/SubscriberEntity.dart';
import 'package:sintir/Core/widgets/CustomAppBar.dart';

class SubscriberDetailsViewBody extends StatelessWidget {
  const SubscriberDetailsViewBody({super.key, required this.subscriberentity});
  static const String routeName = '/SubscriberDetailsViewBody';
  final SubscriberEntity subscriberentity;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(appBartitle: " الطالب ${subscriberentity.name}"),
    );
  }
}

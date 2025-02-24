// ignore_for_file: must_be_immutable, file_names

import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/SubscriberEntity.dart';
import 'package:sintir/Core/widgets/CustomEmptyWidget.dart';
import 'package:sintir/Core/widgets/CustomTextFields/CustomSearchTextField.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CoursedetailsStudentsGridview.dart';

class Coursedetailsstudentspageviewitem extends StatelessWidget {
  Coursedetailsstudentspageviewitem({super.key, required this.subscribers});
  final List<Subscriberentity> subscribers;
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        CustomSearchTextField(controller: controller),
        const SizedBox(
          height: 20,
        ),
        subscribers.isEmpty
            ? const CustomEmptyWidget()
            : CoursedetailsStudentsGridview(
                subscribers: subscribers,
              )
      ],
    );
  }
}

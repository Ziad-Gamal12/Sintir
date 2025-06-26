// ignore_for_file: must_be_immutable, file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/CourseSubscribtionsCubit/CourseSubscribtionsCubit.dart';
import 'package:sintir/Core/entities/CourseEntities/SubscriberEntity.dart';
import 'package:sintir/Core/widgets/CustomEmptyWidget.dart';
import 'package:sintir/Core/widgets/CustomTextFields/CustomSearchTextField.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CoursedetailsStudentsGridview.dart';
import 'package:skeletonizer/skeletonizer.dart';

class Coursedetailsstudentspageviewitem extends StatefulWidget {
  const Coursedetailsstudentspageviewitem(
      {super.key, required this.subscribers});
  final List<Subscriberentity> subscribers;
  @override
  State<Coursedetailsstudentspageviewitem> createState() =>
      _CoursedetailsstudentspageviewitemState();
}

class _CoursedetailsstudentspageviewitemState
    extends State<Coursedetailsstudentspageviewitem> {
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.subscribers.isEmpty) {
      context.read<CourseSubscribtionsCubit>().getCoursSubscribers();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CourseSubscribtionsCubit, CourseSubscribtionsState>(
      builder: (context, state) {
        return Skeletonizer(
          enabled: state is GetCourseSubscribersLoading,
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              CustomSearchTextField(controller: controller),
              const SizedBox(
                height: 20,
              ),
              if (widget.subscribers.isNotEmpty)
                CoursedetailsStudentsGridview(
                  subscribers: widget.subscribers,
                )
              else
                const CustomEmptyWidget()
            ],
          ),
        );
      },
    );
  }
}

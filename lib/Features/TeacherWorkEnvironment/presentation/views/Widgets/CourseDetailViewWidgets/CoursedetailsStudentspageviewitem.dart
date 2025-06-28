// ignore_for_file: must_be_immutable, file_names

import 'dart:async';

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
      {super.key, required this.isFetchedCourseSubscribers});
  final bool isFetchedCourseSubscribers;

  @override
  State<Coursedetailsstudentspageviewitem> createState() =>
      _CoursedetailsstudentspageviewitemState();
}

class _CoursedetailsstudentspageviewitemState
    extends State<Coursedetailsstudentspageviewitem> {
  TextEditingController controller = TextEditingController();
  List<Subscriberentity> searchedSubscribers = [];
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    if (!widget.isFetchedCourseSubscribers) {
      context.read<CourseSubscribtionsCubit>().getCoursSubscribers();
    }
  }

  List<Subscriberentity> getSearchedList({
    required List<Subscriberentity> subscribers,
  }) {
    List<Subscriberentity> searchedSubscribers = [];
    if (controller.text.isNotEmpty) {
      for (Subscriberentity e in subscribers) {
        if ((e.name.toLowerCase()).startsWith(controller.text.toLowerCase())) {
          searchedSubscribers.add(e);
        }
      }
    }
    return searchedSubscribers;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<CourseSubscribtionsCubit, CourseSubscribtionsState,
        List<Subscriberentity>>(
      selector: (state) {
        if (state is GetCourseSubscribersSuccess) {
          return state.subscribers;
        }
        return [];
      },
      builder: (context, state) {
        return Skeletonizer(
          enabled: state is GetCourseSubscribersLoading,
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              CustomSearchTextField(
                controller: controller,
                onSearchChanged: () {
                  if (_debounce?.isActive ?? false) _debounce?.cancel();
                  _debounce = Timer(const Duration(milliseconds: 500), () {
                    searchedSubscribers = getSearchedList(subscribers: state);
                    setState(() {});
                  });
                },
              ),
              const SizedBox(
                height: 20,
              ),
              if (state.isNotEmpty)
                CoursedetailsStudentsGridview(
                  subscribers:
                      searchedSubscribers.isEmpty ? state : searchedSubscribers,
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

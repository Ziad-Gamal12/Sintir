import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sintir/Core/Managers/Cubits/user_cubit/user_cubit.dart';
import 'package:sintir/Core/entities/BottomSheetNavigationRequirmentsEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CoursefedbackItemEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CourseFedBack_Widgets/CourseFedBacksListView.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CourseFedBack_Widgets/CoursefedbackviewBodyActionButton.dart';
import 'package:sintir/constant.dart';

class Coursefedbackviewbody extends StatefulWidget {
  const Coursefedbackviewbody({super.key, required this.requirmentsEntity});
  final DisplayCourseBottomsheetNavigationRequirmentsEntity requirmentsEntity;
  @override
  State<Coursefedbackviewbody> createState() => _CoursefedbackviewbodyState();
}

class _CoursefedbackviewbodyState extends State<Coursefedbackviewbody> {
  late TextEditingController controller;
  late GlobalKey<FormState> formKey;
  late CoursefeedbackItemEntity coursefedbackItemEntity;
  @override
  void initState() {
    controller = TextEditingController();
    formKey = GlobalKey<FormState>();
    coursefedbackItemEntity = CoursefeedbackItemEntity(
        datePosted: DateTime.now(),
        fedBack: "",
        likesCount: 0,
        name: context.read<UserCubit>().studententity?.firstName ?? "",
        userImage: context.read<UserCubit>().studententity?.imageUrl ?? "",
        uid: context.read<UserCubit>().studententity?.uid ?? "");
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: KHorizontalPadding),
        child: Stack(
          children: [
            const Coursefedbackslistview(courseFedBacks: []),
            Positioned(
                bottom: 25,
                left: 0,
                right: 0,
                child: CoursefedbackviewBodyActionButton(
                    controller: controller,
                    requirmentsEntity: widget.requirmentsEntity,
                    formKey: formKey,
                    coursefedbackItemEntity: coursefedbackItemEntity))
          ],
        ),
      ),
    );
  }
}

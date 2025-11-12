import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/CourseFeedBacksCubit/course_feed_backs_cubit.dart';
import 'package:sintir/Core/entities/BottomSheetNavigationRequirmentsEntity.dart';
import 'package:sintir/Core/repos/CourseFeedBacksRepo/CourseFeedBacksRepo.dart';
import 'package:sintir/Core/services/get_it_Service.dart';
import 'package:sintir/Core/widgets/CustomAppBar.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CourseFedBack_Widgets/Coursefedbackviewbody.dart';

class Coursefedbackview extends StatelessWidget {
  const Coursefedbackview({super.key, required this.requirmentsEntity});
  static const routeName = '/Coursefedbackview';
  final DisplayCourseBottomsheetNavigationRequirmentsEntity requirmentsEntity;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CourseFeedBacksCubit(
        courseFeedBacksRepo: getIt<CourseFeedBacksRepo>(),
      ),
      child: Scaffold(
        appBar: CustomAppBar(appBartitle: "اراء الطلاب"),
        body: Coursefedbackviewbody(
          requirmentsEntity: requirmentsEntity,
        ),
      ),
    );
  }
}

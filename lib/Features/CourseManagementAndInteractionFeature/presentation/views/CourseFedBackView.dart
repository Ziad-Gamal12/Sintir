import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/CourseFeedBacksCubit/course_feed_backs_cubit.dart';
import 'package:sintir/Core/Managers/Cubits/MyCourseRatingCubit/my_course_rating_cubit.dart';
import 'package:sintir/Core/entities/BottomSheetNavigationRequirmentsEntity.dart';
import 'package:sintir/Core/helper/GetUserData.dart';
import 'package:sintir/Core/repos/CourseFeedBacksRepo/CourseFeedBacksRepo.dart';
import 'package:sintir/Core/services/get_it_Service.dart';
import 'package:sintir/Core/widgets/CustomAppBar.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/presentation/views/widgets/CourseFedBack_Widgets/Coursefedbackviewbody.dart';
import 'package:sintir/locale_keys.dart';

class Coursefedbackview extends StatelessWidget {
  const Coursefedbackview({super.key, required this.requirmentsEntity});
  static const routeName = "/Coursefedbackview";
  final DisplayCourseBottomsheetNavigationRequirmentsEntity requirmentsEntity;

  @override
  Widget build(BuildContext context) {
    final course = requirmentsEntity.course;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CourseFeedBacksCubit(
            courseFeedBacksRepo: getIt<CourseFeedBacksRepo>(),
          ),
        ),
        BlocProvider(
          create: (context) => MyCourseRatingCubit(
            courseFeedBacksRepo: getIt<CourseFeedBacksRepo>(),
            courseId: course.id,
            teacherId: course.contentcreaterentity?.id,
          ),
        ),
      ],
      child: Scaffold(
        appBar: CustomAppBar(appBartitle: LocaleKeys.studentsReviews),
        body: Coursefedbackviewbody(
          requirmentsEntity: requirmentsEntity,
          currentUid: getUserData().uid,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/widgets/CustomErrorWidget.dart';
import 'package:sintir/Core/widgets/CustomListORGridTextHeader.dart';
import 'package:sintir/Features/Home/presentation/manager/get_courses_cubit/get_courses_cubit.dart';
import 'package:sintir/Features/Home/presentation/views/widgets/bestSellerCourse_ListView.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PopularCoursesSection extends StatelessWidget {
  const PopularCoursesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetCoursesCubit, GetCoursesState>(
      buildWhen: (prev, curr) =>
          curr is GetPopularCoursesLoading ||
          curr is GetPopularCoursesSuccess ||
          curr is GetPopularCoursesFailure,
      builder: (context, state) {
        return SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomListORGridTextHeader(text: "ألاكثر مشاهده"),
              const SizedBox(height: 10),
              if (state is GetPopularCoursesFailure)
                CustomErrorWidget(errormessage: state.errmessage)
              else
                Skeletonizer(
                  enabled: state is GetPopularCoursesLoading,
                  child: BestsellercourseListview(
                      courses: state is GetPopularCoursesSuccess
                          ? state.resonseEntity.courses
                          : CourseEntity.fakeCourses),
                ),
            ],
          ),
        );
      },
    );
  }
}

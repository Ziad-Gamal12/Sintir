import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/helper/GetUserData.dart';
import 'package:sintir/Features/Home/presentation/manager/get_courses_cubit/get_courses_cubit.dart';

extension HomeDataFetch on GetCoursesCubit {
  Future<void> fetchAllHomeData(BuildContext context) async {
    if (!context.mounted) return;
    final user = getUserData();
    final coursesCubit = context.read<GetCoursesCubit>();
    await coursesCubit.getRecentCourses(isPaginate: false);
    await coursesCubit.getUserInterestedCourses(isPaginate: false, user: user);
    await coursesCubit.getPopularCourses(isPaginate: false);
  }
}

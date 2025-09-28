import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/helper/GetUserData.dart';
import 'package:sintir/Features/Profile/Presentation/Manager/ProfileCubit/ProfileCubit.dart';
import 'package:sintir/Features/Profile/Presentation/Views/Widgets/MyCoursesHeader.dart';
import 'package:sintir/Features/Profile/Presentation/Views/Widgets/ProfileViewBodyMyCoursesSliverGrid.dart';
import 'package:sintir/Features/Profile/Presentation/Views/Widgets/UserInfoSection.dart';
import 'package:sintir/Features/Profile/Presentation/Views/Widgets/UserInfoSectionPersonalDetailsHeader.dart';
import 'package:sintir/Features/Profile/Presentation/Views/Widgets/WorkEnvironmentNavigationButton.dart';
import 'package:sintir/constant.dart';

class ProfileViewBody extends StatefulWidget {
  const ProfileViewBody({super.key});

  @override
  State<ProfileViewBody> createState() => _ProfileViewBodyState();
}

class _ProfileViewBodyState extends State<ProfileViewBody> {
  late ScrollController controller;
  bool hasMore = true;
  List<CourseEntity> fetchedMyCourses = [];
  @override
  void initState() {
    super.initState();
    controller = ScrollController();
    final cubit = context.read<ProfileCubit>();
    cubit.getMyCourses(isPaginate: false);
    controller.addListener(
      () {
        if (controller.position.pixels >=
                controller.position.maxScrollExtent - 200 &&
            hasMore &&
            cubit.state is! GetMyCoursesLoading) {
          cubit.getMyCourses(isPaginate: true);
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is GetMyCoursesSuccess) {
          if (state.isPaginate == true) {
            fetchedMyCourses.addAll(state.response.courses);
          } else {
            fetchedMyCourses = state.response.courses;
          }
          hasMore = state.response.hasMore;
          setState(() {});
        }
      },
      child: Padding(
        padding: const EdgeInsetsGeometry.symmetric(
            horizontal: KHorizontalPadding, vertical: KVerticalPadding),
        child: CustomScrollView(
          controller: controller,
          slivers: [
            const SliverToBoxAdapter(child: UserInfoSection()),
            SliverToBoxAdapter(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  const UserInfoSectionPersonalDetailsHeader(),
                  const SizedBox(height: 10),
                  WorkEnvironmentNavigationButton(
                      myCourses: fetchedMyCourses, role: getUserData().role),
                  Divider(
                    thickness: 2,
                    height: 40,
                    color: Colors.grey.shade300,
                  ),
                  const MyCoursesHeader(),
                ],
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 10,
              ),
            ),
            ProfileViewBodyMyCoursesSliverGrid(myCourses: fetchedMyCourses),
          ],
        ),
      ),
    );
  }
}

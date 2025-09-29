import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/helper/GetUserData.dart';
import 'package:sintir/Core/widgets/Custom%20Course%20Widgets/CustomMyCoursesGridHeader.dart';
import 'package:sintir/Core/widgets/CustomButton.dart';
import 'package:sintir/Core/widgets/CustomTextFields/CustomSearchTextField.dart';
import 'package:sintir/Features/Auth/Domain/Entities/UserEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/AddCourseView.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkenvironmentviewWidgets/CustomMyCoursesSliverGrideView.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkenvironmentviewWidgets/CustomTeacherCardItem.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkenvironmentviewWidgets/CustomTeacherWalletDetailsSection.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkenvironmentviewWidgets/TeacherWorkenvironmentviewBodyWalletSectionHeader.dart';
import 'package:sintir/constant.dart';

class TeacherWorkenvironmentviewBody extends StatefulWidget {
  const TeacherWorkenvironmentviewBody({super.key, required this.myCourses});
  final List<CourseEntity> myCourses;

  @override
  State<TeacherWorkenvironmentviewBody> createState() =>
      _TeacherWorkenvironmentviewBodyState();
}

class _TeacherWorkenvironmentviewBodyState
    extends State<TeacherWorkenvironmentviewBody> {
  TextEditingController searchController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    UserEntity user = getUserData();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: KHorizontalPadding),
      child: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 20,
            ),
          ),
          SliverToBoxAdapter(
            child: TeacherWorkenvironmentviewBodyWalletSectionHeader(
              status: user.teacherExtraDataEntity!.wallet.status,
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 10,
            ),
          ),
          SliverToBoxAdapter(
            child: CustomTeacherCardItem(
              user: user,
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 10,
            ),
          ),
          SliverToBoxAdapter(
              child: CustomTeacherWalletDetailsSection(user: user)),
          const SliverToBoxAdapter(
            child: Divider(
              height: 40,
              color: Color(0xffE5E5EA),
            ),
          ),
          SliverToBoxAdapter(
            child: Row(
              children: [
                const Custommycoursesgridheader(),
                const Spacer(),
                Expanded(
                  child: Custombutton(
                      text: "اضافة كورس",
                      color: Colors.grey.shade50,
                      textColor: Colors.black,
                      borderRadius: BorderRadius.circular(8),
                      onPressed: () {
                        GoRouter.of(context).push(Addcourseview.routeName);
                      }),
                ),
              ],
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 10,
            ),
          ),
          SliverToBoxAdapter(
            child: CustomSearchTextField(
                controller: searchController, onSearchChanged: () {}),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 10,
            ),
          ),
          Custommycoursesslivergrideview(
            courses: widget.myCourses,
          )
        ],
      ),
    );
  }
}

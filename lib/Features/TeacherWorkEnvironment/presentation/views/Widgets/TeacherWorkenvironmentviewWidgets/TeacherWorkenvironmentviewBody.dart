import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/content_creator_courses_cubit/content_creator_courses_cubit.dart';
import 'package:sintir/Core/helper/GetUserData.dart';
import 'package:sintir/Core/widgets/Custom%20Course%20Widgets/CustomMyCoursesGridHeader.dart';
import 'package:sintir/Core/widgets/CustomTextFields/CustomSearchTextField.dart';
import 'package:sintir/Features/Auth/Domain/Entities/UserEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkenvironmentviewWidgets/CustomTeacherCardItem.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkenvironmentviewWidgets/TeacherEnvironmentCoursesGrid.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkenvironmentviewWidgets/TeacherWorkenvironmentviewBodyWalletSectionHeader.dart';
import 'package:sintir/constant.dart';

class TeacherWorkenvironmentviewBody extends StatefulWidget {
  const TeacherWorkenvironmentviewBody({
    super.key,
  });

  @override
  State<TeacherWorkenvironmentviewBody> createState() =>
      _TeacherWorkenvironmentviewBodyState();
}

class _TeacherWorkenvironmentviewBodyState
    extends State<TeacherWorkenvironmentviewBody> {
  late TextEditingController searchController;
  UserEntity user = getUserData();
  Timer? _debounce;
  bool isSearching = false;
  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();

    context.read<ContentCreatorCoursesCubit>().getContentCreatorCourses(
          userId: user.uid,
        );

    searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () {
      final keyword = searchController.text.trim();

      if (keyword.isNotEmpty) {
        if (!isSearching) setState(() => isSearching = true);
        context.read<ContentCreatorCoursesCubit>().searchContentCreatorCourses(
              userId: user.uid,
              keyword: keyword,
            );
      } else {
        if (isSearching) setState(() => isSearching = false);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _debounce?.cancel();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              height: 12,
            ),
          ),
          SliverToBoxAdapter(
            child: CustomTeacherCardItem(
              user: user,
            ),
          ),
          const SliverToBoxAdapter(
            child: Divider(
              height: 40,
              color: Color(0xffE5E5EA),
            ),
          ),
          const SliverToBoxAdapter(
            child: Custommycoursesgridheader(),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 12,
            ),
          ),
          SliverToBoxAdapter(
            child: CustomSearchTextField(
              controller: searchController,
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 12,
            ),
          ),
          TeacherEnvironmentCoursesGrid(
            isSearch: isSearching,
          )
        ],
      ),
    );
  }
}

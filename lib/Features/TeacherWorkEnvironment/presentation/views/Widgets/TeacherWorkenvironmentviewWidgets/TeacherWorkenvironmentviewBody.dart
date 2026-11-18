// ignore_for_file: file_names

import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/content_creator_courses_cubit/content_creator_courses_cubit.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/helper/GetUserData.dart';
import 'package:sintir/Features/Auth/Domain/Entities/UserEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkenvironmentviewWidgets/TeacherCourseStatus.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkenvironmentviewWidgets/TeacherCoursesFilterBar.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkenvironmentviewWidgets/TeacherCoursesSectionHeader.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkenvironmentviewWidgets/TeacherEnvironmentCoursesGrid.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkenvironmentviewWidgets/TeacherWorkEnvironmentBreakpoints.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkenvironmentviewWidgets/TeacherWorkEnvironmentWalletSection.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkenvironmentviewWidgets/TeacherWorkenvironmentviewBodyWalletSectionHeader.dart';

class TeacherWorkenvironmentviewBody extends StatefulWidget {
  const TeacherWorkenvironmentviewBody({super.key});

  @override
  State<TeacherWorkenvironmentviewBody> createState() =>
      _TeacherWorkenvironmentviewBodyState();
}

class _TeacherWorkenvironmentviewBodyState
    extends State<TeacherWorkenvironmentviewBody> {
  late final TextEditingController _searchController;
  final UserEntity _user = getUserData();
  Timer? _debounce;
  TeacherCourseStatus _selectedStatus = TeacherCourseStatus.all;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();

    _searchController = TextEditingController();
    context.read<ContentCreatorCoursesCubit>().getContentCreatorCourses(
      userId: _user.uid,
    );
  }

  void _onSearchChanged(String value) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 250), () {
      if (mounted) {
        setState(() {
          _searchQuery = value;
        });
      }
    });
  }

  void _onStatusSelected(TeacherCourseStatus status) {
    if (_selectedStatus != status) {
      setState(() {
        _selectedStatus = status;
      });
    }
  }

  void _onClearFilters() {
    _searchController.clear();
    setState(() {
      _searchQuery = '';
      _selectedStatus = TeacherCourseStatus.all;
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  (int, int, int, int) _computeCounts(List<CourseEntity> courses) {
    int published = 0;
    int inReview = 0;
    int archived = 0;

    for (final course in courses) {
      final status = TeacherCourseStatus.fromRaw(course.state);
      if (status == TeacherCourseStatus.published) {
        published++;
      } else if (status == TeacherCourseStatus.inReview) {
        inReview++;
      } else if (status == TeacherCourseStatus.archived) {
        archived++;
      }
    }
    return (courses.length, published, inReview, archived);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContentCreatorCoursesCubit, ContentCreatorCoursesState>(
      buildWhen: (previous, current) =>
          current is GetContentCreatorCoursesSuccess ||
          current is GetContentCreatorCoursesLoading,
      builder: (context, state) {
        final courses = state is GetContentCreatorCoursesSuccess
            ? state.coursesList
            : context.read<ContentCreatorCoursesCubit>().contentCreatorCourses;

        final (allCount, publishedCount, inReviewCount, archivedCount) =
            _computeCounts(courses);

        return LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;
            final isExpanded = width >= 1024;
            final isMedium = width >= 600 && width < 1024;
            final horizontalPadding = isMedium ? 24.0 : 16.0;

            if (isExpanded) {
              return Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: TeacherWorkEnvironmentLayout.maxContentWidth,
                  ),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.symmetric(
                      horizontal: 24,
                      vertical: 16,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Start Pane (Wallet Section)
                        SizedBox(
                          width: TeacherWorkEnvironmentLayout.startPaneWidth,
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                TeacherWorkenvironmentviewBodyWalletSectionHeader(),
                                SizedBox(height: 12),
                                TeacherWorkEnvironmentWalletSection(),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 24),
                        // End Pane (Courses Toolbar and Grid)
                        Expanded(
                          child: CustomScrollView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            slivers: [
                              const SliverToBoxAdapter(
                                child: TeacherCoursesSectionHeader(),
                              ),
                              const SliverToBoxAdapter(
                                child: SizedBox(height: 12),
                              ),
                              SliverToBoxAdapter(
                                child: TeacherCoursesFilterBar(
                                  searchController: _searchController,
                                  selectedStatus: _selectedStatus,
                                  onStatusSelected: _onStatusSelected,
                                  allCount: allCount,
                                  publishedCount: publishedCount,
                                  inReviewCount: inReviewCount,
                                  archivedCount: archivedCount,
                                  onSearchChanged: _onSearchChanged,
                                ),
                              ),
                              const SliverToBoxAdapter(
                                child: SizedBox(height: 16),
                              ),
                              TeacherEnvironmentCoursesGrid(
                                selectedStatus: _selectedStatus,
                                searchQuery: _searchQuery,
                                onClearFilters: _onClearFilters,
                              ),
                              const SliverToBoxAdapter(
                                child: SizedBox(height: 24),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }

            // Compact & Medium single-scroll layout
            return Padding(
              padding: EdgeInsetsDirectional.symmetric(
                horizontal: horizontalPadding,
              ),
              child: CustomScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                slivers: [
                  const SliverToBoxAdapter(child: SizedBox(height: 16)),
                  const SliverToBoxAdapter(
                    child: TeacherWorkenvironmentviewBodyWalletSectionHeader(),
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 12)),
                  const SliverToBoxAdapter(
                    child: TeacherWorkEnvironmentWalletSection(),
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 24)),
                  const SliverToBoxAdapter(
                    child: TeacherCoursesSectionHeader(),
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 12)),
                  SliverToBoxAdapter(
                    child: TeacherCoursesFilterBar(
                      searchController: _searchController,
                      selectedStatus: _selectedStatus,
                      onStatusSelected: _onStatusSelected,
                      allCount: allCount,
                      publishedCount: publishedCount,
                      inReviewCount: inReviewCount,
                      archivedCount: archivedCount,
                      onSearchChanged: _onSearchChanged,
                    ),
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 16)),
                  TeacherEnvironmentCoursesGrid(
                    selectedStatus: _selectedStatus,
                    searchQuery: _searchQuery,
                    onClearFilters: _onClearFilters,
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 24)),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

// ignore_for_file: file_names

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/helper/ShowSnackBar.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkspace/TeacherCoursesSectionHeader.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkspace/TeacherWorkspaceBreakpoints.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkspace/TeacherWorkspaceWalletSection.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkspace/TeacherWorkspaceWalletSectionHeader.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkspace/TeacherWorkspaceAttentionSection.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkspace/TeacherWorkspaceCoursesGrid.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkspace/TeacherWorkspaceCoursesToolbar.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkspace/TeacherWorkspaceSummarySection.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/teacher_courses_cubit/teacher_courses_cubit.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/teacher_workspace_insights_cubit/teacher_workspace_insights_cubit.dart';
import 'package:sintir/constant.dart';

class TeacherWorkspaceViewBody extends StatefulWidget {
  const TeacherWorkspaceViewBody({super.key});

  @override
  State<TeacherWorkspaceViewBody> createState() =>
      _TeacherWorkspaceViewBodyState();
}

class _TeacherWorkspaceViewBodyState extends State<TeacherWorkspaceViewBody> {
  static const Duration _searchDebounce = Duration(milliseconds: 250);

  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    _debounce?.cancel();
    _debounce = Timer(_searchDebounce, () {
      if (mounted) context.read<TeacherCoursesCubit>().setSearch(value);
    });
  }

  void _syncSearchField(BuildContext context, TeacherCoursesState state) {
    if (_searchController.text != state.query.search) {
      _searchController.text = state.query.search;
    }
  }

  void _loadInsights(BuildContext context, TeacherCoursesState state) {
    context.read<TeacherWorkspaceInsightsCubit>().load(
      state.courses,
      silent: true,
    );
  }

  Future<void> _refresh() async {
    final message = await context.read<TeacherCoursesCubit>().refresh();
    if (!mounted || message == null) return;
    CustomSnackBar.show(context, message: message, type: SnackType.error);
  }

  List<Widget> _overview() => const [
    TeacherWorkenvironmentviewBodyWalletSectionHeader(),
    SizedBox(height: 12),
    TeacherWorkEnvironmentWalletSection(),
    SizedBox(height: 24),
    TeacherWorkspaceSummarySection(),
    SizedBox(height: 24),
    TeacherWorkspaceAttentionSection(),
  ];

  List<Widget> _courseSlivers() => [
    const SliverToBoxAdapter(child: TeacherCoursesSectionHeader()),
    const SliverToBoxAdapter(child: SizedBox(height: 12)),
    SliverToBoxAdapter(
      child: TeacherWorkspaceCoursesToolbar(
        searchController: _searchController,
        onSearchChanged: _onSearchChanged,
      ),
    ),
    const SliverToBoxAdapter(child: SizedBox(height: 16)),
    const TeacherWorkspaceCoursesGrid(),
    const SliverToBoxAdapter(child: SizedBox(height: 24)),
  ];

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<TeacherCoursesCubit, TeacherCoursesState>(
          listenWhen: (previous, current) =>
              current.isLoaded && previous.courses != current.courses,
          listener: _loadInsights,
        ),
        BlocListener<TeacherCoursesCubit, TeacherCoursesState>(
          listenWhen: (previous, current) =>
              previous.query.search != current.query.search,
          listener: _syncSearchField,
        ),
      ],
      child: RefreshIndicator(
        color: KMainColor,
        onRefresh: _refresh,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final breakpoint = WorkEnvironmentBreakpoint.fromWidth(
              constraints.maxWidth,
            );
            if (breakpoint == WorkEnvironmentBreakpoint.expanded) {
              return _ExpandedLayout(
                overview: _overview(),
                courseSlivers: _courseSlivers(),
              );
            }
            final padding = breakpoint == WorkEnvironmentBreakpoint.medium
                ? 24.0
                : 16.0;
            return CustomScrollView(
              key: const ValueKey('workspace-scroll'),
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                SliverPadding(
                  padding: EdgeInsets.fromLTRB(padding, 16, padding, 24),
                  sliver: SliverList.list(children: _overview()),
                ),
                SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: padding),
                  sliver: SliverMainAxisGroup(slivers: _courseSlivers()),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _ExpandedLayout extends StatelessWidget {
  const _ExpandedLayout({required this.overview, required this.courseSlivers});

  final List<Widget> overview;
  final List<Widget> courseSlivers;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: TeacherWorkEnvironmentLayout.maxContentWidth,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: TeacherWorkEnvironmentLayout.startPaneWidth,
                child: ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  children: overview,
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: CustomScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  slivers: [
                    const SliverToBoxAdapter(child: SizedBox(height: 16)),
                    ...courseSlivers,
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

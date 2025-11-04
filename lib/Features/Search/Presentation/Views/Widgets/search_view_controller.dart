import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Features/Search/Domain/Entities/CustomFilterEntity.dart';
import 'package:sintir/Features/Search/Presentation/Managers/cubit/search_cubit.dart';

class SearchViewController {
  final TextEditingController textController = TextEditingController();
  bool isSearching = false;
  Timer? _debounce;

  void init(BuildContext context,
      {required String? userId, required CourseFilterEntity? filters}) {
    final cubit = context.read<SearchCubit>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      cubit.getDefaultCourses(filters: filters, userId: userId);
      cubit.getDefaultTeachers();
      _setupTextListener(context, cubit, filters, userId);
    });
  }

  void _setupTextListener(BuildContext context, SearchCubit cubit,
      CourseFilterEntity? filters, String? userId) {
    textController.addListener(() {
      setupTextListenerHandler(cubit, filters, userId);
    });
  }

  void setupTextListenerHandler(
      SearchCubit cubit, CourseFilterEntity? filters, String? userId) {
    final text = textController.text.trim();
    _debounce?.cancel();
    if (text.isEmpty) {
      isSearching = false;
      cubit.getDefaultCourses(filters: filters, userId: userId);
    } else {
      isSearching = true;
      _debounce = Timer(const Duration(milliseconds: 800), () {
        cubit.search(keyword: text, filters: filters, userId: userId);
      });
    }
  }

  void dispose() {
    textController.dispose();
    _debounce?.cancel();
  }
}

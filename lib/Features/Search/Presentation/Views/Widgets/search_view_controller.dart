import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Features/Search/Presentation/Managers/cubit/search_cubit.dart';

class SearchViewController {
  final TextEditingController textController = TextEditingController();
  bool isSearching = false;
  Timer? _debounce;

  void init(BuildContext context) {
    final cubit = context.read<SearchCubit>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      cubit.getDefaultCourses();
      cubit.getDefaultTeachers();

      textController.addListener(() {
        final text = textController.text;
        if (text.isNotEmpty) {
          isSearching = true;
          _debounce?.cancel();
          _debounce = Timer(const Duration(milliseconds: 800), () {
            cubit.search(keyword: text);
          });
        } else {
          isSearching = false;
        }
      });
    });
  }

  void dispose() {
    textController.dispose();
    _debounce?.cancel();
  }
}

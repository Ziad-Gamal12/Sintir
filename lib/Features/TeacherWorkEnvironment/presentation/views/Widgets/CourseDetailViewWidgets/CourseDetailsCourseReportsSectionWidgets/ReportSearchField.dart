import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/CourseReportsCubit/course_reports_cubit.dart';
import 'package:sintir/locale_keys.dart';

class ReportSearchField extends StatefulWidget {
  const ReportSearchField(
      {super.key, required this.onChanged, this.autofocus = false});
  final ValueChanged<String> onChanged;
  final bool autofocus;
  @override
  State<ReportSearchField> createState() => _ReportSearchFieldState();
}

class _ReportSearchFieldState extends State<ReportSearchField> {
  late final TextEditingController controller;
  Timer? debounce;
  @override
  void initState() {
    super.initState();
    controller = TextEditingController(
        text: context.read<CourseReportsCubit>().searchQuery);
  }

  @override
  void dispose() {
    debounce?.cancel();
    controller.dispose();
    super.dispose();
  }

  void changed(String value) {
    debounce?.cancel();
    debounce =
        Timer(const Duration(milliseconds: 300), () => widget.onChanged(value));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) => TextField(
        controller: controller,
        autofocus: widget.autofocus,
        textInputAction: TextInputAction.search,
        onChanged: changed,
        decoration: InputDecoration(
          hintText: LocaleKeys.reportSearchHint,
          prefixIcon: const Icon(Icons.search),
          suffixIcon: controller.text.isEmpty
              ? null
              : IconButton(
                  tooltip: LocaleKeys.reportClearFilters,
                  onPressed: () {
                    controller.clear();
                    changed('');
                  },
                  icon: const Icon(Icons.clear)),
          isDense: true,
        ),
      );
}

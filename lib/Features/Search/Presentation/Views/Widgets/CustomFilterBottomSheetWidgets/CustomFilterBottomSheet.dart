import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sintir/Features/Search/Domain/Entities/CustomFilterEntity.dart';
import 'package:sintir/Features/Search/Presentation/Views/Widgets/CustomFilterBottomSheetWidgets/CustomFilterBottomSheetBody.dart';

class CustomFilterBottomSheet extends StatefulWidget {
  const CustomFilterBottomSheet({super.key});

  @override
  State<CustomFilterBottomSheet> createState() =>
      _CustomFilterBottomSheetState();
}

class _CustomFilterBottomSheetState extends State<CustomFilterBottomSheet> {
  CourseFilterEntity courseFilterEntity = CourseFilterEntity();

  @override
  Widget build(BuildContext context) {
    return Provider.value(
        value: courseFilterEntity, child: const CustomFilterBottomSheetBody());
  }
}

import 'package:flutter/material.dart';
import 'package:sintir/Core/widgets/CustomEmptyWidget.dart';

class SearchTeachersEmptyWidget extends StatelessWidget {
  const SearchTeachersEmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomEmptyWidget(text: "لا يوجد مدرسين"),
    );
  }
}

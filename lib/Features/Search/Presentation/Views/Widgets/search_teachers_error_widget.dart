import 'package:flutter/material.dart';
import 'package:sintir/Core/widgets/CustomErrorWidget.dart';

class SearchTeachersErrorWidget extends StatelessWidget {
  final String errorMessage;
  const SearchTeachersErrorWidget({super.key, required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomErrorWidget(errormessage: errorMessage),
    );
  }
}

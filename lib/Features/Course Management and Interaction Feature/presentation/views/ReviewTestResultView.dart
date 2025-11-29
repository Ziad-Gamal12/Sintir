import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/TestResulteEntity.dart';
import 'package:sintir/Core/widgets/CustomAppBar.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/ReviewTestResultWidgets/ReviewtestresultviewBody.dart';
import 'package:sintir/locale_keys.dart';

class Reviewtestresultview extends StatelessWidget {
  const Reviewtestresultview({super.key, required this.resultEntity});
  static const routeName = '/Reviewtestresultview';
  final TestResultEntity resultEntity;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(appBartitle: LocaleKeys.myResultsAppbar),
      body: Provider.value(
          value: resultEntity, child: const Reviewtestresultviewbody()),
    );
  }
}

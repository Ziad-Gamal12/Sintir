import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:sintir/Core/Managers/Cubits/CourseReportsCubit/course_reports_cubit.dart';
import 'package:sintir/Core/entities/BottomSheetNavigationRequirmentsEntity.dart';
import 'package:sintir/Core/repos/CourseReportsRepo/CourseReportsRepo.dart';
import 'package:sintir/Core/services/get_it_Service.dart';
import 'package:sintir/Core/widgets/CustomAppBar.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseReportsItemEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/SendReport_Widgets/SendcoursereportviewBody.dart';

class Sendcoursereportview extends StatefulWidget {
  const Sendcoursereportview({
    super.key,
    required this.requirmentsEntity,
  });
  static const routeName = "/sendcoursereportview";
  final DisplayCourseBottomsheetNavigationRequirmentsEntity requirmentsEntity;
  @override
  State<Sendcoursereportview> createState() => _SendcoursereportviewState();
}

class _SendcoursereportviewState extends State<Sendcoursereportview> {
  CourseReportEntity coursereportsitementity = CourseReportEntity(
    date: DateTime.now(),
    description: "",
    type: "",
  );
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CourseReportsCubit(
        coursereportsrepo: getIt<CourseReportsRepo>(),
      ),
      child: Provider.value(
        value: coursereportsitementity,
        child: Scaffold(
          appBar: CustomAppBar(appBartitle: "ابلاغ"),
          body: Sendcoursereportviewbody(
            requirmentsEntity: widget.requirmentsEntity,
          ),
        ),
      ),
    );
  }
}

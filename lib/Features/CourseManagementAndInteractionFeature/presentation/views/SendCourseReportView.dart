import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/CourseReportsCubit/course_reports_cubit.dart';
import 'package:sintir/Core/entities/BottomSheetNavigationRequirmentsEntity.dart';
import 'package:sintir/Core/repos/CourseReportsRepo/CourseReportsRepo.dart';
import 'package:sintir/Core/services/get_it_Service.dart';
import 'package:sintir/Core/widgets/CustomAppBar.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/presentation/views/widgets/SendReport_Widgets/SendcoursereportviewBody.dart';
import 'package:sintir/locale_keys.dart';

class Sendcoursereportview extends StatefulWidget {
  const Sendcoursereportview({super.key, required this.requirmentsEntity});
  static const routeName = "/sendcoursereportview";
  final DisplayCourseBottomsheetNavigationRequirmentsEntity requirmentsEntity;
  @override
  State<Sendcoursereportview> createState() => _SendcoursereportviewState();
}

class _SendcoursereportviewState extends State<Sendcoursereportview> {
  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (_) =>
            CourseReportsCubit(coursereportsrepo: getIt<CourseReportsRepo>()),
        child: Scaffold(
          appBar: CustomAppBar(appBartitle: LocaleKeys.report),
          body: Sendcoursereportviewbody(
              requirmentsEntity: widget.requirmentsEntity),
        ),
      );
}

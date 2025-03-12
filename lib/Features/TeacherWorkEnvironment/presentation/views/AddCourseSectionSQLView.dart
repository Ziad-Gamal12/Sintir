import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/entities/CourseEntity.dart';
import 'package:sintir/Core/services/PickerAssetsService.dart';
import 'package:sintir/Core/services/get_it_Service.dart';
import 'package:sintir/Core/widgets/CustomAppBar.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/repos/AddCourseSectionRepo.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddSqlTestWidgets/AddcoursesectionsqlviewBody.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/AddCourseSectionCubit/AddCourseSectionCubit.dart';

class Addcoursesectionsqlview extends StatefulWidget {
  const Addcoursesectionsqlview({super.key, required this.courseEntity});
  static const routeName = '/Addcoursesectionsqlview';
  final CourseEntity courseEntity;
  @override
  State<Addcoursesectionsqlview> createState() =>
      _AddcoursesectionsqlviewState();
}

class _AddcoursesectionsqlviewState extends State<Addcoursesectionsqlview>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider(
      create: (context) => AddCourseSectionCubit(
          getIt<Addcoursesectionrepo>(), getIt<Pickerassetsservice>()),
      child: Scaffold(
        appBar: const CustomAppBar(appBartitle: "SQL"),
        body: AddcoursesectionsqlviewBody(
          courseEntity: widget.courseEntity,
        ),
      ),
    );
  }
}

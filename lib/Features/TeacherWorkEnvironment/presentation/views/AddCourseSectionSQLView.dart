import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/widgets/CustomAppBar.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddcoursesectionviewWidgets/AddcoursesectionsqlviewBody.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/add_sql_test_cubit/add_sql_test_cubit.dart';

class Addcoursesectionsqlview extends StatelessWidget {
  const Addcoursesectionsqlview({super.key});
  static const routeName = '/Addcoursesectionsqlview';
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddSQlTestCubit(),
      child: const Scaffold(
        appBar: CustomAppBar(appBartitle: "SQL"),
        body: AddcoursesectionsqlviewBody(),
      ),
    );
  }
}

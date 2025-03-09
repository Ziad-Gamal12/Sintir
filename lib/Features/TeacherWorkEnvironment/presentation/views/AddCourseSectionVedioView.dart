import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:sintir/Core/services/get_it_Service.dart';
import 'package:sintir/Core/widgets/CustomAppBar.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/repos/AddCourseSectionRepo.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddCourseSectionVedio/AddcoursesectionvedioviewBody.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/AddCourseSectionCubit/AddCourseSectionCubit.dart';

class Addcoursesectionvedioview extends StatelessWidget {
  const Addcoursesectionvedioview({super.key});
  static const routeName = '/Addcoursesectionvedioview';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context1) =>
          AddCourseSectionCubit(getIt<Addcoursesectionrepo>()),
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: const CustomAppBar(appBartitle: "اضافة فيديو"),
          body: Provider.value(
              value:
                  context.read<AddCourseSectionCubit>().coursevedioitementity,
              child: const Addcoursesectionvedioviewbody()),
        );
      }),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/content_creator_courses_cubit/content_creator_courses_cubit.dart';
import 'package:sintir/Core/services/get_it_Service.dart';
import 'package:sintir/Core/widgets/CustomAppBar.dart';
import 'package:sintir/Features/ContentCreatorProfile/domain/Repos/ContentCreatorProfileRepo.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkenvironmentviewWidgets/AddCourseFloatingActionButton.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkenvironmentviewWidgets/TeacherWorkenvironmentviewBody.dart';

class TeacherWorkenvironmentview extends StatelessWidget {
  const TeacherWorkenvironmentview({
    super.key,
  });
  static const routeName = '/TeacherWorkenvironmentview';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(appBartitle: "بيئة العمل"),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: const AddCourseFloatingActionButton(),
      body: BlocProvider(
        create: (context) => ContentCreatorCoursesCubit(
          contentCreatorProfileRepo: getIt<ContentCreatorProfileRepo>(),
        ),
        child: const TeacherWorkenvironmentviewBody(),
      ),
    );
  }
}

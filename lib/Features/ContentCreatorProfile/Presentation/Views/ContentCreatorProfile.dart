import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/content_creator_courses_cubit/content_creator_courses_cubit.dart';
import 'package:sintir/Core/entities/CourseEntities/ContentCreaterEntity.dart';
import 'package:sintir/Core/services/get_it_Service.dart';
import 'package:sintir/Core/widgets/CustomAppBar.dart';
import 'package:sintir/Features/ContentCreatorProfile/Presentation/Views/Widgets/ContentCreatorProfileBody.dart';
import 'package:sintir/Features/ContentCreatorProfile/domain/Repos/ContentCreatorProfileRepo.dart';

class ContentCreatorProfile extends StatelessWidget {
  const ContentCreatorProfile({super.key, required this.contentcreaterentity});
  static const routeName = '/ContentCreatorProfile';
  final Contentcreaterentity contentcreaterentity;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(appBartitle: "تفاصيل المعلم"),
        body: BlocProvider(
          create: (context) => ContentCreatorCoursesCubit(
            contentCreatorProfileRepo: getIt<ContentCreatorProfileRepo>(),
          ),
          child: ContentCreatorProfileBody(
              contentcreaterentity: contentcreaterentity),
        ));
  }
}

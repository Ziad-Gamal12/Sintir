import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/services/get_it_Service.dart';
import 'package:sintir/Core/widgets/CustomAppBar.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/SubscriberDetailsNavigationRequirements.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Repos/SubscribersDetailsRepo.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSubscribers_SectionWidgets/SubscriberDetails/widgets/SubscriberDetailsViewBody.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/subuscriber_details_cubit/subuscriber_details_cubit.dart';

class SubscriberDetailsView extends StatelessWidget {
  const SubscriberDetailsView({super.key, required this.requirements});
  static const String routeName = '/SubscriberDetailsViewBody';
  final SubscriberDetailsNavigationRequirements requirements;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(appBartitle: requirements.subscriber.name),
      body: BlocProvider(
        create: (context) => SubscriberDetailsCubit(
          subscribersDetailsRepo: getIt.get<SubscribersDetailsRepo>(),
        ),
        child: SubscriberDetailsViewBody(
          requirements: requirements,
        ),
      ),
    );
  }
}

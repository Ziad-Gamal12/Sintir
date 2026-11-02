import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/services/get_it_Service.dart';
import 'package:sintir/Core/widgets/CustomAppBar.dart';
import 'package:sintir/Core/widgets/results/results_tokens.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/SubscriberDetailsNavigationRequirements.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Repos/SubscribersDetailsRepo.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSubscribers_SectionWidgets/SubscriberDetails/widgets/SubscriberDetailsViewBody.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/subuscriber_details_cubit/subuscriber_details_cubit.dart';
import 'package:sintir/locale_keys.dart';

class SubscriberDetailsView extends StatelessWidget {
  const SubscriberDetailsView({super.key, required this.requirements});
  static const String routeName = '/SubscriberDetailsViewBody';
  final SubscriberDetailsNavigationRequirements requirements;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final tokens = ResultsTokens.of(theme);
    return BlocProvider(
      create: (_) => SubscriberDetailsCubit(
          subscribersDetailsRepo: getIt.get<SubscribersDetailsRepo>()),
      child: Scaffold(
        backgroundColor: tokens.page,
        appBar: CustomAppBar(
          appBartitle: LocaleKeys.subscriberDetailsTitle,
        ),
        body: SafeArea(
          top: false,
          child: SubscriberDetailsViewBody(requirements: requirements),
        ),
      ),
    );
  }
}

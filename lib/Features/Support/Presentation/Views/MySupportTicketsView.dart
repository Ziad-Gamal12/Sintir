import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/helper/GetUserData.dart';
import 'package:sintir/Core/services/get_it_Service.dart';
import 'package:sintir/Core/widgets/CustomAppBar.dart';
import 'package:sintir/Features/Support/Domain/Repos/SupportTicketsRepo.dart';
import 'package:sintir/Features/Support/Presentation/Managers/support_tickets_cubit/support_tickets_cubit.dart';
import 'package:sintir/Features/Support/Presentation/Views/Widgets/MySupportTicketsViewWidgets/MySupportTicketsViewBody.dart';
import 'package:sintir/Features/Support/Presentation/Views/Widgets/MySupportTicketsViewWidgets/MySupportTicketsViewFloatingButton.dart';
import 'package:sintir/locale_keys.dart';

class MySupportTicketsView extends StatelessWidget {
  const MySupportTicketsView({super.key});
  static const routeName = '/MySupportTicketsView';
  @override
  Widget build(BuildContext context) {
    // Above the Scaffold so the add button can hand new tickets to the list.
    return BlocProvider(
      create: (context) => SupportTicketsCubit(
        supportTicketsRepo: getIt.get<SupportTicketsRepo>(),
      ),
      child: Scaffold(
        appBar: CustomAppBar(appBartitle: LocaleKeys.support),
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: const MySupportTicketsViewFloatingButton(),
        body: MySupportTicketsViewBody(userId: getUserData().uid),
      ),
    );
  }
}

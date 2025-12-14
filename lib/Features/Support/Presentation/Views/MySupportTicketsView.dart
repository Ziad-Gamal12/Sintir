import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/services/get_it_Service.dart';
import 'package:sintir/Core/widgets/CustomAppBar.dart';
import 'package:sintir/Features/Support/Domain/Repos/SupportTicketsRepo.dart';
import 'package:sintir/Features/Support/Presentation/Managers/support_tickets_cubit/support_tickets_cubit.dart';
import 'package:sintir/Features/Support/Presentation/Views/AddSupportTicketView.dart';
import 'package:sintir/Features/Support/Presentation/Views/Widgets/MySupportTicketsViewWidgets/MySupportTicketsViewBody.dart';
import 'package:sintir/constant.dart';
import 'package:sintir/locale_keys.dart';

class MySupportTicketsView extends StatelessWidget {
  const MySupportTicketsView({super.key});
  static const routeName = '/MySupportTicketsView';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(appBartitle: LocaleKeys.support),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: KMainColor,
        onPressed: () {
          GoRouter.of(context).push(AddSupportTicketView.routeName);
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: BlocProvider(
        create: (context) => SupportTicketsCubit(
          supportTicketsRepo: getIt.get<SupportTicketsRepo>(),
        ),
        child: const MySupportTicketsViewBody(),
      ),
    );
  }
}

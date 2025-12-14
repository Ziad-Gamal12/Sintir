import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/services/get_it_Service.dart';
import 'package:sintir/Core/widgets/CustomAppBar.dart';
import 'package:sintir/Features/Support/Domain/Repos/SupportTicketsRepo.dart';
import 'package:sintir/Features/Support/Presentation/Managers/support_tickets_cubit/support_tickets_cubit.dart';
import 'package:sintir/Features/Support/Presentation/Views/Widgets/AddSupportTicketViewWidgets/AddSupportTicketViewBody.dart';
import 'package:sintir/locale_keys.dart';

class AddSupportTicketView extends StatelessWidget {
  const AddSupportTicketView({super.key});
  static const routeName = '/AddSupportTicketView';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(appBartitle: LocaleKeys.addTicket),
      body: BlocProvider(
        create: (context) => SupportTicketsCubit(
          supportTicketsRepo: getIt.get<SupportTicketsRepo>(),
        ),
        child: const AddSupportTicketViewBody(),
      ),
    );
  }
}

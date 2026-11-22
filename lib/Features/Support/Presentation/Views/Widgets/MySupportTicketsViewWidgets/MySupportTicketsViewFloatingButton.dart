import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Features/Support/Domain/Entities/SupportTicketEntity.dart';
import 'package:sintir/Features/Support/Presentation/Managers/support_tickets_cubit/support_tickets_cubit.dart';
import 'package:sintir/Features/Support/Presentation/Views/AddSupportTicketView.dart';
import 'package:sintir/constant.dart';

class MySupportTicketsViewFloatingButton extends StatelessWidget {
  const MySupportTicketsViewFloatingButton({super.key});

  Future<void> _openAddTicket(BuildContext context) async {
    final cubit = context.read<SupportTicketsCubit>();
    // The add screen pops with the sent ticket, or null if it was left
    // without sending.
    final ticket = await GoRouter.of(
      context,
    ).push<SupportTicketEntity>(AddSupportTicketView.routeName);
    if (ticket != null && !cubit.isClosed) {
      cubit.showAddedTicket(ticket);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      key: const ValueKey('support-add-ticket-button'),
      backgroundColor: KMainColor,
      onPressed: () => _openAddTicket(context),
      child: const Icon(Icons.add, color: Colors.white),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Features/Support/Domain/Entities/SupportTicketEntity.dart';
import 'package:sintir/Features/Support/Presentation/Views/SupportTicketChatView.dart';
import 'package:sintir/Features/Support/Presentation/Views/Widgets/MySupportTicketsViewWidgets/MySupportTicketsListViewItem.dart';

class MySupportTicketsViewBodyMySupportTicketsSliverListView
    extends StatelessWidget {
  const MySupportTicketsViewBodyMySupportTicketsSliverListView(
      {super.key, required this.supportTickets});
  final List<SupportTicketEntity> supportTickets;
  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: supportTickets.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: InkWell(
            onTap: () {
              GoRouter.of(context).push(SupportTicketChatView.routeName,
                  extra: supportTickets[index]);
            },
            child: MySupportTicketsListViewItem(
                supportTicketEntity: supportTickets[index]),
          ),
        );
      },
    );
  }
}

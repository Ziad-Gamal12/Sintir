import 'package:flutter/material.dart';
import 'package:sintir/Features/Support/Domain/Entities/SupportTicketEntity.dart';
import 'package:sintir/Features/Support/Presentation/Views/Widgets/MySupportTicketsViewWidgets/MySupportTicketsListViewItem.dart';
import 'package:sintir/constant.dart';
import 'package:skeletonizer/skeletonizer.dart';

class MySupportTicketsViewBodyLoadingListView extends StatelessWidget {
  const MySupportTicketsViewBodyLoadingListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: SupportTicketEntity.fakeSupportTickets().length,
      padding: const EdgeInsets.symmetric(horizontal: KHorizontalPadding),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Skeletonizer(
              enabled: true,
              child: MySupportTicketsListViewItem(
                  supportTicketEntity:
                      SupportTicketEntity.fakeSupportTickets()[index])),
        );
      },
    );
  }
}

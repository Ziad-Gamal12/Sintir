import 'package:flutter/material.dart';
import 'package:sintir/Core/widgets/CustomAppBar.dart';
import 'package:sintir/Features/Support/Domain/Entities/SupportTicketEntity.dart';
import 'package:sintir/Features/Support/Presentation/Views/Widgets/SupportTicketChatViewWidgets/SupportTicketChatViewBody.dart';
import 'package:sintir/locale_keys.dart';

class SupportTicketChatView extends StatelessWidget {
  const SupportTicketChatView({super.key, required this.supportTicketEntity});

  static String routeName = "/SupportTicketChatView";
  final SupportTicketEntity supportTicketEntity;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        appBartitle: LocaleKeys.support,
      ),
      body: const SupportTicketChatViewBody(),
    );
  }
}

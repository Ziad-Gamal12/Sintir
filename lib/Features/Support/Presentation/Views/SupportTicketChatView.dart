import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/services/get_it_Service.dart';
import 'package:sintir/Core/widgets/CustomAppBar.dart';
import 'package:sintir/Features/Support/Domain/Entities/SupportTicketEntity.dart';
import 'package:sintir/Features/Support/Domain/Repos/SupportChatRepo.dart';
import 'package:sintir/Features/Support/Presentation/Managers/support_chat_cubit/support_chat_cubit.dart';
import 'package:sintir/Features/Support/Presentation/Views/Widgets/SupportTicketChatViewWidgets/SupportTicketChatViewBody.dart';
import 'package:sintir/locale_keys.dart';

class SupportTicketChatView extends StatelessWidget {
  const SupportTicketChatView({super.key, required this.supportTicketEntity});

  static String routeName = "/SupportTicketChatView";
  final SupportTicketEntity supportTicketEntity;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SupportChatCubit(
        supportChatRepo: getIt.get<SupportChatRepo>(),
      ),
      child: Scaffold(
        appBar: CustomAppBar(
          appBartitle: LocaleKeys.support,
        ),
        body: SupportTicketChatViewBody(
          supportTicketEntity: supportTicketEntity,
        ),
      ),
    );
  }
}

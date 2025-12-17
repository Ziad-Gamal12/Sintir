import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/services/get_it_Service.dart';
import 'package:sintir/Features/Support/Domain/Entities/SupportChatMessageEntity.dart';
import 'package:sintir/Features/Support/Domain/Repos/SupportChatRepo.dart';
import 'package:sintir/Features/Support/Presentation/Managers/support_chat_cubit/support_chat_cubit.dart';
import 'package:sintir/Features/Support/Presentation/Views/Widgets/SupportTicketChatViewWidgets/UpdateMessageBottomSheetWidgets/UpdateMessageBottomSheetBody.dart';

class UpdateMessageBottomSheet extends StatelessWidget {
  const UpdateMessageBottomSheet(
      {super.key, required this.ticketId, required this.messageEntity});
  final String ticketId;
  final SupportChatMessageEntity messageEntity;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) =>
            SupportChatCubit(supportChatRepo: getIt.get<SupportChatRepo>()),
        child: IntrinsicHeight(
          child: UpdateMessageBottomSheetBody(
            ticketId: ticketId,
            messageEntity: messageEntity,
          ),
        ));
  }
}

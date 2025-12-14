import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/widgets/AwesomeDialog.dart';
import 'package:sintir/Core/widgets/CustomButton.dart';
import 'package:sintir/Core/widgets/Custom_Loading_Widget.dart';
import 'package:sintir/Features/Support/Domain/Entities/SupportTicketEntity.dart';
import 'package:sintir/Features/Support/Presentation/Managers/support_tickets_cubit/support_tickets_cubit.dart';
import 'package:sintir/constant.dart';
import 'package:sintir/locale_keys.dart';

class CustomAddSupportTicketActionButton extends StatelessWidget {
  const CustomAddSupportTicketActionButton({super.key, required this.formKey});
  final GlobalKey<FormState> formKey;
  @override
  Widget build(BuildContext context) {
    return BlocSelector<SupportTicketsCubit, SupportTicketsState, bool>(
        selector: (state) => state is SendSupportTicketLoading,
        builder: (context, isLoading) {
          return Custom_Loading_Widget(
            isLoading: isLoading,
            child: Custombutton(
                text: LocaleKeys.send,
                color: KMainColor,
                textColor: Colors.white,
                onPressed: () {
                  final ticket = context.read<SupportTicketEntity>();
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    if (ticket.category.isEmpty) {
                      errordialog(
                        context,
                        LocaleKeys.selectTicketCategory,
                      ).show();
                    }
                    context.read<SupportTicketsCubit>().sendSupportTicket(
                          supportTicket: ticket,
                        );
                  }
                }),
          );
        });
  }
}

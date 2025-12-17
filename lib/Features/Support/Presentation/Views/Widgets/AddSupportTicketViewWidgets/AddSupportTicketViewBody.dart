import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sintir/Core/helper/GetUserData.dart';
import 'package:sintir/Core/helper/ShowSnackBar.dart';
import 'package:sintir/Core/utils/Backend_EndPoints.dart';
import 'package:sintir/Features/Auth/Domain/Entities/UserEntity.dart';
import 'package:sintir/Features/Support/Domain/Entities/SupportSenderEntity.dart';
import 'package:sintir/Features/Support/Domain/Entities/SupportTicketEntity.dart';
import 'package:sintir/Features/Support/Presentation/Managers/support_tickets_cubit/support_tickets_cubit.dart';
import 'package:sintir/Features/Support/Presentation/Views/Widgets/AddSupportTicketViewWidgets/AddSupportTicketInputs.dart';
import 'package:sintir/Features/Support/Presentation/Views/Widgets/AddSupportTicketViewWidgets/CustomAddSupportTicketActionButton.dart';
import 'package:sintir/constant.dart';
import 'package:sintir/locale_keys.dart';

class AddSupportTicketViewBody extends StatefulWidget {
  const AddSupportTicketViewBody({super.key});

  @override
  State<AddSupportTicketViewBody> createState() =>
      _AddSupportTicketViewBodyState();
}

class _AddSupportTicketViewBodyState extends State<AddSupportTicketViewBody> {
  SupportTicketEntity supportTicketEntity = SupportTicketEntity(
      sender: SupportSenderEntity(
          name: "", email: "", phone: "", role: "", uid: "", photoUrl: ""),
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      title: "",
      category: "",
      description: "",
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      status: BackendEndpoints.pending);
  GlobalKey<FormState> supportTicketFormKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    UserEntity userEntity = getUserData();
    supportTicketEntity.sender.uid = userEntity.uid;
    supportTicketEntity.sender.role = userEntity.role;
    supportTicketEntity.sender.photoUrl = userEntity.profilePicurl;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SupportTicketsCubit, SupportTicketsState>(
        listener: (context, state) {
          if (state is SendSupportTicketSuccess) {
            CustomSnackBar.show(context,
                message: LocaleKeys.ticketSentSuccess, type: SnackType.success);
            GoRouter.of(context).pop();
          } else if (state is SendSupportTicketFailure) {
            CustomSnackBar.show(context,
                message: state.errMessage, type: SnackType.error);
          }
        },
        child: Padding(
          padding: const EdgeInsetsGeometry.symmetric(
              horizontal: KHorizontalPadding, vertical: KVerticalPadding),
          child: Provider.value(
            value: supportTicketEntity,
            child: Form(
              key: supportTicketFormKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const AddSupportTicketInputs(),
                    const SizedBox(
                      height: 32,
                    ),
                    CustomAddSupportTicketActionButton(
                      formKey: supportTicketFormKey,
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}

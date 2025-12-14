import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sintir/Core/widgets/CustomAnimatedDropDownButton.dart';
import 'package:sintir/Features/Support/Domain/Entities/SupportTicketEntity.dart';

class CustomAddSupportTicketCategoryDropdwonButton extends StatefulWidget {
  const CustomAddSupportTicketCategoryDropdwonButton({super.key});

  @override
  State<CustomAddSupportTicketCategoryDropdwonButton> createState() =>
      _CustomAddSupportTicketCategoryDropdwonButtonState();
}

class _CustomAddSupportTicketCategoryDropdwonButtonState
    extends State<CustomAddSupportTicketCategoryDropdwonButton> {
  List<String> categoryList = [
    // Technical Issues
    "TECHNICAL_ISSUE",
    "SOFTWARE_BUG",
    "CONNECTIVITY_ISSUE",
    "PERFORMANCE_COMPLAINT",

    "ACCOUNT_ACCESS",
    "PASSWORD_RESET",
    "PROFILE_UPDATE",
    "CANCELLATION_REQUEST",

    "BILLING_INQUIRY",
    "REFUND_REQUEST",
    "PAYMENT_FAILURE",

    "FEATURE_REQUEST",
    "USAGE_GUIDANCE",
    "CHANGE_REQUEST",

    "GENERAL_INQUIRY",
    "COMPLAINT_FEEDBACK",
    "POLICY_QUESTION",
    "OTHER",
  ];
  @override
  Widget build(BuildContext context) {
    return CustomAnimatedDropDownButton(
      items: categoryList,
      onChanged: (value) {
        context.read<SupportTicketEntity>().category = value ?? "";
      },
    );
  }
}

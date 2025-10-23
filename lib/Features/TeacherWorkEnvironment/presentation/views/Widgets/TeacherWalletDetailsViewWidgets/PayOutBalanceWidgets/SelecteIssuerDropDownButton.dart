import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';

class SelecteIssuerDropDownButton extends StatefulWidget {
  const SelecteIssuerDropDownButton({super.key, required this.onSelected});
  final ValueChanged<String?> onSelected;

  @override
  State<SelecteIssuerDropDownButton> createState() =>
      _SelecteIssuerDropDownButtonState();
}

class _SelecteIssuerDropDownButtonState
    extends State<SelecteIssuerDropDownButton> {
  String? selectedValue = "vodafone";

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: AlignmentDirectional.center,
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: DropdownButton<String>(
        onChanged: (val) {
          widget.onSelected(val);
          setState(() {
            selectedValue = val;
          });
        },
        value: selectedValue,
        isExpanded: true,
        icon: const Icon(
          Icons.wallet_rounded,
          color: Colors.grey,
        ),
        isDense: true,
        dropdownColor: Colors.grey.shade50,
        barrierDismissible: true,
        borderRadius: BorderRadius.circular(10),
        padding: const EdgeInsets.all(10),
        autofocus: true,
        underline: Container(),
        focusColor: Colors.grey.shade200,
        items: [
          DropdownMenuItem(
            value: "vodafone",
            child: Text(
              "Vodafone",
              style: AppTextStyles(context).semiBold12,
            ),
          ),
          DropdownMenuItem(
            value: "etisalat",
            child: Text(
              "Etisalat",
              style: AppTextStyles(context).semiBold12,
            ),
          ),
          DropdownMenuItem(
            value: "orange",
            child: Text(
              "Orange",
              style: AppTextStyles(context).semiBold12,
            ),
          ),
          DropdownMenuItem(
            value: "aman",
            child: Text(
              "Aman",
              style: AppTextStyles(context).semiBold12,
            ),
          ),
        ],
      ),
    );
  }
}

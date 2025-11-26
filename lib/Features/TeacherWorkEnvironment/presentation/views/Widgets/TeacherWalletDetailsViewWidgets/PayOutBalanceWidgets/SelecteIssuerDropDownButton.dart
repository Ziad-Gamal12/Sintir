import 'package:flutter/material.dart';
import 'package:sintir/Core/widgets/CustomAnimatedDropDownButton.dart';
import 'package:sintir/locale_keys.dart';

class SelecteIssuerDropDownButton extends StatefulWidget {
  const SelecteIssuerDropDownButton({super.key, required this.onSelected});
  final ValueChanged<String?> onSelected;

  @override
  State<SelecteIssuerDropDownButton> createState() =>
      _SelecteIssuerDropDownButtonState();
}

class _SelecteIssuerDropDownButtonState
    extends State<SelecteIssuerDropDownButton> {
  List<String> items = ["vodafone", "etisalat", "orange", "we"];

  @override
  Widget build(BuildContext context) {
    return CustomAnimatedDropDownButton(
        items: items,
        hintText: LocaleKeys.wallet,
        onChanged: (val) {
          widget.onSelected(val);
        });
  }
}

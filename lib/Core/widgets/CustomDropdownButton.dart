import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';

class CustomDropdownButton extends StatefulWidget {
  const CustomDropdownButton({
    super.key,
    required this.items,
    required this.hintText,
    required this.valueChanged,
  });
  final List<DropdownMenuItem<String>> items;
  final String hintText;
  final ValueChanged<String?> valueChanged;
  @override
  State<CustomDropdownButton> createState() => _CustomDropdownButtonState();
}

class _CustomDropdownButtonState extends State<CustomDropdownButton> {
  String? currentvalue;

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
        value: currentvalue,
        dropdownColor: Colors.white,
        hint: Text(widget.hintText),
        style: AppTextStyles.semiBold12.copyWith(color: Colors.black),
        borderRadius: BorderRadius.circular(10),
        alignment: AlignmentDirectional.center,
        elevation: 3,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        items: widget.items,
        onChanged: (value) {
          currentvalue = value;
          setState(() {});
          widget.valueChanged(currentvalue);
        });
  }
}

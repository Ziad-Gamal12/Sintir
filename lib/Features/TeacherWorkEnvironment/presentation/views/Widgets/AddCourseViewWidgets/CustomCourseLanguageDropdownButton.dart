import 'package:flutter/material.dart';
import 'package:sintir/Core/widgets/CustomAnimatedDropDownButton.dart';

class CustomLanguageDropdownButton extends StatefulWidget {
  const CustomLanguageDropdownButton({super.key, required this.onValueChange});
  final ValueChanged<String?> onValueChange;
  @override
  State<CustomLanguageDropdownButton> createState() =>
      _CustomLanguageDropdownButtonState();
}

class _CustomLanguageDropdownButtonState
    extends State<CustomLanguageDropdownButton> {
  List<String> items = ["العربية", "English", "أخرى"];
  @override
  Widget build(BuildContext context) {
    return CustomAnimatedDropDownButton(
      hintText: "اللغة",
      items: items,
      onChanged: widget.onValueChange,
    );
  }
}

// ignore_for_file: must_be_immutable, file_names

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';

class CustomAnimatedDropDownButton extends StatelessWidget {
  CustomAnimatedDropDownButton(
      {super.key, required this.items, required this.onChanged, this.hintText});
  final List<String> items;
  final ValueChanged<String?> onChanged;
  String? hintText;

  Future<List<String>> _getFakeRequestData(String query) async {
    return await Future.delayed(const Duration(seconds: 1), () {
      return items.where((e) {
        return e.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomDropdown<String>.searchRequest(
      futureRequest: _getFakeRequestData,
      hintText: hintText ?? 'برجاء الأختيار',
      decoration: CustomDropdownDecoration(
        closedFillColor: const Color(0xffF9FAFA),
        closedBorder: BoxBorder.all(
          color: const Color(0xffD1D1D1),
        ),
        closedBorderRadius: const BorderRadius.all(Radius.circular(14)),
      ),
      items: items,
      onChanged: (value) {
        onChanged(value);
      },
    );
  }
}

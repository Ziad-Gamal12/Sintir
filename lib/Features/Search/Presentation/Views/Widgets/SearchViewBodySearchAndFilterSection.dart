import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sintir/Core/widgets/CustomTextFields/CustomSearchTextField.dart';

class SearchViewBodySearchAndFilterSection extends StatelessWidget {
  const SearchViewBodySearchAndFilterSection({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomSearchTextField(
              controller: controller, onSearchChanged: () {}),
        ),
        const SizedBox(
          width: 20,
        ),
        IconButton(
            onPressed: () {},
            icon: const Icon(
              FontAwesomeIcons.filter,
              size: 25,
            ))
      ],
    );
  }
}

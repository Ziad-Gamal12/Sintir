import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sintir/Core/helper/ShowBottomSheet.dart';
import 'package:sintir/Core/widgets/CustomTextFields/CustomSearchTextField.dart';
import 'package:sintir/Features/Search/Presentation/Views/Widgets/CustomFilterBottomSheetWidgets/CustomFilterBottomSheet.dart';

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
            controller: controller,
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        IconButton(
            onPressed: () {
              showCustomBottomSheet(
                  child: const CustomFilterBottomSheet(), context: context);
            },
            icon: const Icon(
              FontAwesomeIcons.barsStaggered,
              size: 25,
            ))
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sintir/Core/helper/GetUserData.dart';
import 'package:sintir/Core/helper/ShowBottomSheet.dart';
import 'package:sintir/Core/widgets/CustomTextFields/CustomSearchTextField.dart';
import 'package:sintir/Features/Search/Presentation/Views/Widgets/CustomFilterBottomSheetWidgets/CustomFilterBottomSheet.dart';
import 'package:sintir/Features/Search/Presentation/Views/Widgets/search_view_controller.dart';

class SearchViewBodySearchAndFilterSection extends StatelessWidget {
  const SearchViewBodySearchAndFilterSection({
    super.key,
    required this.controller,
    required this.isSearching,
  });

  final TextEditingController controller;
  final bool isSearching;

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
                  child: CustomFilterBottomSheet(
                    onFilterChanged: (value) {
                      SearchViewController().getCoursesWithFilters(context,
                          userId: getUserData().uid, filters: value);
                    },
                  ),
                  context: context);
            },
            icon: const Icon(
              FontAwesomeIcons.barsStaggered,
              size: 25,
            ))
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sintir/Core/helper/GetUserData.dart';
import 'package:sintir/Core/helper/ShowBottomSheet.dart';
import 'package:sintir/Core/widgets/CustomTextFields/CustomSearchTextField.dart';
import 'package:sintir/Features/Search/Presentation/Managers/cubit/search_cubit.dart';
import 'package:sintir/Features/Search/Presentation/Views/Widgets/CustomFilterBottomSheetWidgets/CustomFilterBottomSheet.dart';
import 'package:sintir/Features/Search/Presentation/Views/Widgets/search_view_controller.dart';

class SearchViewBodySearchAndFilterSection extends StatelessWidget {
  const SearchViewBodySearchAndFilterSection({
    super.key,
    required this.controller,
  });
  final SearchViewController controller;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomSearchTextField(
            controller: controller.textController,
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        IconButton(
            onPressed: () {
              final cubit = context.read<SearchCubit>();
              String? userId = getUserData().uid;
              showCustomBottomSheet(
                  child: CustomFilterBottomSheet(
                    onFilterChanged: (value) {
                      controller.setupTextListenerHandler(cubit, value, userId);
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

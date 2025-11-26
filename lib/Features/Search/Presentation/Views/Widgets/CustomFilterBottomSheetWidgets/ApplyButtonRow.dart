import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/widgets/CustomButton.dart';
import 'package:sintir/Features/Search/Domain/Entities/CustomFilterEntity.dart';
import 'package:sintir/Features/Search/Presentation/Views/Widgets/CustomFilterBottomSheetWidgets/ClearFilters.dart';
import 'package:sintir/constant.dart';
import 'package:sintir/locale_keys.dart';

class ApplyButtonRow extends StatelessWidget {
  const ApplyButtonRow({super.key, required this.onFilterChanged});
  final ValueChanged<CourseFilterEntity?> onFilterChanged;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Expanded(
              flex: 4,
              child: Custombutton(
                text: LocaleKeys.filter,
                color: KMainColor,
                textColor: Colors.white,
                onPressed: () {
                  onFilterChanged(context.read<CourseFilterEntity>());
                  GoRouter.of(context).pop(context);
                },
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(child: ClearFilters(onFilterChanged: onFilterChanged)),
          ],
        ),
      ),
    );
  }
}

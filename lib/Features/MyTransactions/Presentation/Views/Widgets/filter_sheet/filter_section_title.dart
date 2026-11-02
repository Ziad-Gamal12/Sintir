import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';

class FilterSectionTitle extends StatelessWidget {
  const FilterSectionTitle({super.key, required this.title, this.helper});
  final String title;
  final String? helper;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 18, bottom: 8),
    child: Row(
      children: [
        Expanded(child: Text(title, style: AppTextStyles(context).semiBold14)),
        if (helper != null)
          Text(
            helper!,
            style: AppTextStyles(context).regular11.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
      ],
    ),
  );
}

import 'package:flutter/material.dart';

class FilterChoice extends StatelessWidget {
  const FilterChoice({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
    this.icon,
  });
  final String label;
  final bool selected;
  final VoidCallback onTap;
  final IconData? icon;

  @override
  Widget build(BuildContext context) => ChoiceChip(
    label: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) ...[Icon(icon, size: 16), const SizedBox(width: 5)],
        Text(label),
      ],
    ),
    selected: selected,
    onSelected: (_) => onTap(),
  );
}

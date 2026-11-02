import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';

class FilterMethodTile extends StatelessWidget {
  const FilterMethodTile({
    super.key,
    required this.label,
    required this.icon,
    required this.id,
    required this.values,
    required this.onChanged,
    this.full = false,
  });
  final String label, id;
  final IconData icon;
  final Set<String> values;
  final void Function(String, bool) onChanged;
  final bool full;

  @override
  Widget build(BuildContext context) => SizedBox(
    width: full ? double.infinity : null,
    child: InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () => onChanged(id, !values.contains(id)),
      child: Container(
        padding: const EdgeInsetsDirectional.fromSTEB(10, 6, 6, 6),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary.withValues(alpha: .06),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, size: 18, color: Theme.of(context).colorScheme.primary),
            const SizedBox(width: 8),
            Expanded(
              child: Text(label, style: AppTextStyles(context).regular12),
            ),
            Checkbox(
              value: values.contains(id),
              onChanged: (value) => onChanged(id, value ?? false),
              visualDensity: VisualDensity.compact,
            ),
          ],
        ),
      ),
    ),
  );
}

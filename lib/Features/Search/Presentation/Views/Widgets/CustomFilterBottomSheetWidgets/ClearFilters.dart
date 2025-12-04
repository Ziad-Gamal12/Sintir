import 'package:flutter/material.dart';
import 'package:sintir/Features/Search/Domain/Entities/CustomFilterEntity.dart';
import 'package:sintir/locale_keys.dart';

class ClearFilters extends StatelessWidget {
  const ClearFilters({
    super.key,
    required this.onFilterChanged,
  });

  final ValueChanged<CourseFilterEntity?> onFilterChanged;

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Tooltip(
      message: LocaleKeys.restoreDefaultFilters,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isDark ? Colors.grey[900] : Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 3),
            )
          ],
          shape: BoxShape.circle,
        ),
        child: IconButton(
            onPressed: () {
              onFilterChanged(null);
              Navigator.pop(context);
            },
            icon: const Icon(Icons.refresh)),
      ),
    );
  }
}

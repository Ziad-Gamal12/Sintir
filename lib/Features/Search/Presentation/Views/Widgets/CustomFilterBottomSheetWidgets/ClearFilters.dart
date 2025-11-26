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
    return Tooltip(
      message: LocaleKeys.restoreDefaultFilters,
      child: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
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

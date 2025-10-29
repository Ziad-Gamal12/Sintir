import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';

class FilterSectionCard extends StatefulWidget {
  final String title;
  final Widget child;

  const FilterSectionCard({
    super.key,
    required this.title,
    required this.child,
  });

  @override
  State<FilterSectionCard> createState() => _FilterSectionCardState();
}

class _FilterSectionCardState extends State<FilterSectionCard> {
  // small state to animate elevation on tap
  bool _pressed = false;

  void _onTapDown(_) => setState(() => _pressed = true);
  void _onTapUp(_) => setState(() => _pressed = false);
  void _onTapCancel() => setState(() => _pressed = false);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(horizontal: 2),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: _pressed
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  )
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  )
                ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.title, style: AppTextStyles(context).semiBold16),
            const SizedBox(height: 10),
            widget.child,
          ],
        ),
      ),
    );
  }
}

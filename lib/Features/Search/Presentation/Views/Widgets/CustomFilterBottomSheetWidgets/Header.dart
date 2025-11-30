import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/locale_keys.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(
          width: 26,
        ),
        const Spacer(),
        // Drag handle center
        Expanded(
          flex: 6,
          child: Column(
            children: [
              Container(
                width: 60,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                LocaleKeys.filterCourses,
                style: AppTextStyles(context).semiBold20,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        const Spacer(),
        IconButton(
          onPressed: () {
            GoRouter.of(context).pop();
          },
          icon: const Icon(
            Icons.close_rounded,
            size: 26,
          ),
        )
      ],
    );
  }
}

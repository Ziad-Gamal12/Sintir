import 'package:flutter/material.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkenvironmentviewWidgets/TeacherWorkEnvironmentTheme.dart';

/// Tinted square holding the wallet glyph.
class TeacherWalletIconBox extends StatelessWidget {
  const TeacherWalletIconBox({super.key});

  @override
  Widget build(BuildContext context) {
    final tokens = WorkEnvironmentThemeExtension.of(context);

    return Container(
      width: 44,
      height: 44,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: tokens.primaryTint,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: tokens.primaryBorder),
      ),
      child: Icon(
        Icons.credit_card_rounded,
        color: Theme.of(context).colorScheme.primary,
        size: 22,
      ),
    );
  }
}

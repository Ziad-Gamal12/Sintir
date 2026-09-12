import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/Auth/Domain/Entities/TeacherWalletEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWalletDetailsViewWidgets/EarningsSummarySection/EarningsSummaryCards.dart';

class EarningsSummarySection extends StatelessWidget {
  const EarningsSummarySection({super.key, required this.teacherWallet});
  final TeacherWalletEntity teacherWallet;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    bool isDarkMode = theme.brightness == Brightness.dark;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        EarningsSummaryHeader(theme: theme, isDarkMode: isDarkMode),
        SizedBox(height: 10),
        EarningsSummaryCards(teacherWalletEntity: teacherWallet),
      ],
    );
  }
}

class EarningsSummaryHeader extends StatelessWidget {
  const EarningsSummaryHeader({
    super.key,
    required this.theme,
    required this.isDarkMode,
  });

  final ThemeData theme;
  final bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("ملخص الأرباح",
            style: AppTextStyles(context).bold16.copyWith(
                  color: theme.textTheme.bodyLarge?.color,
                )),
        Text(
          "تحديث دوري فوري",
          style: AppTextStyles(context).regular12.copyWith(
                color: isDarkMode ? Color(0xff8E909F) : Color(0xff64748B),
              ),
        ),
      ],
    );
  }
}

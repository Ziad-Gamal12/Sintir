import 'package:flutter/material.dart';
import 'package:sintir/Core/Enums/currency_enum.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/locale_keys.dart';

class TeacherWalletAvailableBalance extends StatelessWidget {
  const TeacherWalletAvailableBalance({
    super.key,
    required this.isDark,
    required this.balance,
    required this.currency,
    required this.theme,
  });

  final bool isDark;
  final String balance;
  final String currency;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LocaleKeys.availableBalanceLabel,
          style: AppTextStyles(context)
              .medium12
              .copyWith(color: isDark ? Color(0xffC4C5D6) : Color(0xff475569)),
        ),
        SizedBox(
          height: 4,
        ),
        FittedBox(
          fit: BoxFit.scaleDown,
          alignment: AlignmentDirectional.centerStart,
          child: Text.rich(
            TextSpan(
              text: "$balance ",
              style: AppTextStyles(context).bold30.copyWith(
                    color: isDark ? Colors.white : Colors.black,
                  ),
              children: [
                TextSpan(
                  text: currencyFromString(currency).symbol,
                  style: AppTextStyles(context).medium12.copyWith(
                        color: theme.colorScheme.primary,
                      ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:localingo/localingo.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/WithdrawalMethodEntity.dart';
import 'package:sintir/locale_keys.dart';
import 'package:svg_flutter/svg_flutter.dart';
import 'WithdrawalSurfaceCard.dart';

class WithdrawalMethodsCard extends StatelessWidget {
  const WithdrawalMethodsCard(
      {super.key,
      required this.methods,
      required this.selectedId,
      required this.onSelected});
  final List<WithdrawalMethodEntity> methods;
  final String selectedId;
  final ValueChanged<WithdrawalMethodEntity> onSelected;
  @override
  Widget build(BuildContext context) => WithdrawalSurfaceCard(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Text(LocaleKeys.withdrawalReceivingMethod,
            style: AppTextStyles(context).bold16),
        const SizedBox(height: 12),
        Wrap(
            spacing: 10,
            runSpacing: 10,
            children: methods
                .map((method) => _MethodTile(
                    method: method,
                    selected: method.id == selectedId,
                    onTap: () => onSelected(method)))
                .toList())
      ]));
}

class _MethodTile extends StatelessWidget {
  const _MethodTile(
      {required this.method, required this.selected, required this.onTap});
  final WithdrawalMethodEntity method;
  final bool selected;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    final styles = AppTextStyles(context);
    final foreground = dark ? Colors.white : const Color(0xFF172036);
    final inactiveBackground =
        dark ? const Color(0xFF292929) : const Color(0xFFF9FAFC);
    final activeBackground =
        dark ? const Color(0xFF3A3029) : const Color(0xFFFFF4EF);
    return Semantics(
        selected: selected,
        button: true,
        label: method.nameKey.tr(),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(14),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              curve: Curves.easeOut,
              width: (MediaQuery.sizeOf(context).width - 74) / 2,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: selected ? activeBackground : inactiveBackground,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                    color: selected
                        ? const Color(0xFFFF7D16)
                        : (dark ? Colors.white12 : const Color(0xFFDDE5F0)),
                    width: selected ? 1.5 : 1),
                boxShadow: selected && !dark
                    ? const [
                        BoxShadow(
                            color: Color(0x1AFF7D16),
                            blurRadius: 8,
                            offset: Offset(0, 3))
                      ]
                    : null,
              ),
              child: Row(children: [
                Container(
                    width: 38,
                    height: 38,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: dark ? Colors.white10 : Colors.white,
                        borderRadius: BorderRadius.circular(11)),
                    child: SvgPicture.asset(method.svgAssetPath)),
                const SizedBox(width: 9),
                Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      Row(children: [
                        Expanded(
                            child: Text(method.nameKey.tr(),
                                style: styles.semiBold13
                                    .copyWith(color: foreground),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis)),
                        if (selected)
                          const Icon(Icons.check_circle_rounded,
                              color: Color(0xFFFF7D16), size: 16)
                      ]),
                      const SizedBox(height: 2),
                      Text(method.subtitleKey.tr(),
                          style: styles.regular10.copyWith(
                              color: dark
                                  ? Colors.white60
                                  : const Color(0xFF71809A)),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis),
                    ])),
              ]),
            ),
          ),
        ));
  }
}

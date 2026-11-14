import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/constant.dart';
import 'package:sintir/locale_keys.dart';

class LoadingMessageCard extends StatelessWidget {
  const LoadingMessageCard({super.key, this.message});

  final String? message;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Semantics(
      liveRegion: true,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 320),
        child: Material(
          color: colors.surface,
          elevation: 6,
          shadowColor: Colors.black45,
          borderRadius: BorderRadius.circular(16),
          clipBehavior: Clip.antiAlias,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox.square(
                  dimension: 22,
                  child: CircularProgressIndicator(
                    color: KMainColor,
                    strokeWidth: 2.5,
                  ),
                ),
                const SizedBox(width: 14),
                Flexible(
                  child: Text(
                    message ?? LocaleKeys.loggingIn,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles(
                      context,
                    ).semiBold16.copyWith(color: colors.onSurface),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

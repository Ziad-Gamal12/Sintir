import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/imageAssets.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/RetryOnReconnect.dart';
import 'package:sintir/locale_keys.dart';
import 'package:svg_flutter/svg_flutter.dart';

class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget({super.key, required this.errormessage, this.onRetry});
  final String errormessage;
  final VoidCallback? onRetry;

  static bool isConnectionError(String message) =>
      message == LocaleKeys.noInternet ||
      message == LocaleKeys.serverUnavailable ||
      message == LocaleKeys.deadlineExceeded ||
      message == LocaleKeys.connectionTimeout ||
      message == LocaleKeys.serverConnectionError;

  @override
  Widget build(BuildContext context) {
    final offline = isConnectionError(errormessage);
    final theme = Theme.of(context);
    final content = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (offline)
          Icon(
            Icons.wifi_off_rounded,
            size: 64,
            color: theme.colorScheme.onSurfaceVariant,
          )
        else
          SvgPicture.asset(Assets.assetsImagesSVGImagesErorr,
              height: 70, width: 70, fit: BoxFit.fill),
        const SizedBox(
          height: 10,
        ),
        Text(errormessage,
            textAlign: TextAlign.center,
            style: AppTextStyles(context).semiBold16),
        if (offline && onRetry != null) ...[
          const SizedBox(height: 6),
          Text(
            LocaleKeys.offlineAutoRetryHint,
            textAlign: TextAlign.center,
            style: AppTextStyles(context).regular13.copyWith(
                  color: theme.textTheme.bodySmall?.color,
                ),
          ),
        ],
        if (onRetry != null) ...[
          const SizedBox(height: 8),
          TextButton.icon(
            key: const ValueKey('error-retry-button'),
            onPressed: onRetry,
            icon: const Icon(Icons.refresh_rounded),
            label: Text(LocaleKeys.tryAgain),
          ),
        ],
      ],
    );
    final retry = onRetry;
    if (retry == null) return content;
    return RetryOnReconnect(onReconnect: retry, child: content);
  }
}

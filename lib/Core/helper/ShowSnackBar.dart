// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/locale_keys.dart';

enum SnackType { success, error, warning, info }

class CustomSnackBar {
  static void show(
    BuildContext context, {
    required String message,
    required SnackType type,
  }) {
    final colorData = _getSnackData(type);

    final snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      elevation: 0,
      backgroundColor: Colors.transparent,
      duration: const Duration(seconds: 3),
      content: _SnackContent(
        icon: colorData.icon,
        iconColor: colorData.color,
        title: colorData.title,
        message: message,
      ),
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  static _SnackBarData _getSnackData(SnackType type) {
    switch (type) {
      case SnackType.success:
        return _SnackBarData(
          title: LocaleKeys.snackSuccess,
          icon: Icons.check_circle,
          color: Colors.green,
        );
      case SnackType.error:
        return _SnackBarData(
          title: LocaleKeys.snackError,
          icon: Icons.error,
          color: Colors.redAccent,
        );
      case SnackType.warning:
        return _SnackBarData(
          title: LocaleKeys.snackWarning,
          icon: Icons.warning_amber_rounded,
          color: Colors.orangeAccent,
        );
      case SnackType.info:
        return _SnackBarData(
          title: LocaleKeys.snackInfo,
          icon: Icons.info_outline,
          color: Colors.blueAccent,
        );
    }
  }
}

class _SnackBarData {
  final String title;
  final IconData icon;
  final Color color;

  _SnackBarData({required this.title, required this.icon, required this.color});
}

class _SnackContent extends StatelessWidget {
  final String title;
  final String message;
  final IconData icon;
  final Color iconColor;

  const _SnackContent({
    required this.title,
    required this.message,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final style = AppTextStyles(context);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
          ),
        ],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: iconColor.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            padding: const EdgeInsets.all(10),
            child: Icon(icon, color: iconColor, size: 24),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(title, style: style.semiBold16.copyWith(color: iconColor)),
                const SizedBox(height: 3),
                Text(message,
                    style: style.regular14.copyWith(color: Colors.black87)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/network_status_cubit/network_status_cubit.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/locale_keys.dart';

class NetworkStatusBanner extends StatelessWidget {
  const NetworkStatusBanner({super.key, required this.child});

  final Widget child;

  static const Color offlineColor = Color(0xFFB3261E);
  static const Color restoredColor = Color(0xFF1E7D3A);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NetworkStatusCubit, NetworkBannerStatus>(
      builder: (context, status) {
        final visible = status != NetworkBannerStatus.online;
        return Column(
          children: [
            AnimatedSize(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeOut,
              child: visible
                  ? _NetworkBar(status: status)
                  : const SizedBox(width: double.infinity),
            ),
            Expanded(
              child: MediaQuery.removePadding(
                context: context,
                removeTop: visible,
                child: child,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _NetworkBar extends StatelessWidget {
  const _NetworkBar({required this.status});

  final NetworkBannerStatus status;

  @override
  Widget build(BuildContext context) {
    final offline = status == NetworkBannerStatus.offline;
    final message = offline
        ? LocaleKeys.offlineBannerMessage
        : LocaleKeys.connectionRestored;
    return Semantics(
      liveRegion: true,
      container: true,
      label: message,
      child: Material(
        key: ValueKey('network-banner-${status.name}'),
        color: offline
            ? NetworkStatusBanner.offlineColor
            : NetworkStatusBanner.restoredColor,
        child: SafeArea(
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Icon(
                  offline ? Icons.wifi_off_rounded : Icons.wifi_rounded,
                  color: Colors.white,
                  size: 18,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ExcludeSemantics(
                    child: Text(
                      message,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles(
                        context,
                      ).semiBold13.copyWith(color: Colors.white),
                    ),
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

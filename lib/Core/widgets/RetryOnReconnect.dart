// ignore_for_file: file_names

import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:sintir/Core/services/NetworkStatus.dart';

class RetryOnReconnect extends StatefulWidget {
  const RetryOnReconnect({
    super.key,
    required this.onReconnect,
    required this.child,
    this.network,
  });

  final VoidCallback onReconnect;
  final Widget child;
  final NetworkStatus? network;

  @override
  State<RetryOnReconnect> createState() => _RetryOnReconnectState();
}

class _RetryOnReconnectState extends State<RetryOnReconnect> {
  StreamSubscription<bool>? _subscription;

  @override
  void initState() {
    super.initState();
    _subscription = (widget.network ?? NetworkStatus.current).changes.listen((
      online,
    ) {
      if (online && mounted) widget.onReconnect();
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}

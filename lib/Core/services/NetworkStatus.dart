// ignore_for_file: file_names

import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';

abstract class NetworkStatus {
  bool get isOnline;

  Stream<bool> get changes;

  static NetworkStatus current = const AlwaysOnlineNetworkStatus();
}

class AlwaysOnlineNetworkStatus implements NetworkStatus {
  const AlwaysOnlineNetworkStatus();

  @override
  bool get isOnline => true;

  @override
  Stream<bool> get changes => const Stream<bool>.empty();
}

typedef InternetProbe = Future<bool> Function();
typedef ConnectivityCheck = Future<List<ConnectivityResult>> Function();

class ConnectivityService implements NetworkStatus {
  ConnectivityService({
    Stream<List<ConnectivityResult>>? connectivityChanges,
    ConnectivityCheck? checkConnectivity,
    InternetProbe? probe,
    this.recheckInterval = const Duration(seconds: 15),
  }) : _connectivityChanges = connectivityChanges,
       _checkConnectivity = checkConnectivity,
       _probe = probe ?? defaultProbe;

  final Stream<List<ConnectivityResult>>? _connectivityChanges;
  final ConnectivityCheck? _checkConnectivity;
  final InternetProbe _probe;
  final Duration recheckInterval;

  final StreamController<bool> _controller = StreamController<bool>.broadcast();
  StreamSubscription<List<ConnectivityResult>>? _subscription;
  Timer? _recheck;
  bool _isOnline = true;
  int _generation = 0;

  @override
  bool get isOnline => _isOnline;

  @override
  Stream<bool> get changes => _controller.stream;

  Future<void> start() async {
    final changes =
        _connectivityChanges ?? Connectivity().onConnectivityChanged;
    _subscription = changes.listen(_evaluate);
    await refresh();
  }

  Future<bool> refresh() async {
    try {
      final check = _checkConnectivity ?? Connectivity().checkConnectivity;
      await _evaluate(await check());
    } catch (_) {
      await _evaluate(const [ConnectivityResult.other]);
    }
    return _isOnline;
  }

  static bool hasNetworkInterface(List<ConnectivityResult> results) =>
      results.any((result) => result != ConnectivityResult.none);

  Future<void> _evaluate(List<ConnectivityResult> results) async {
    final generation = ++_generation;
    if (!hasNetworkInterface(results)) {
      _set(false);
      return;
    }
    final reachable = await _probe();
    if (generation != _generation) return;
    _set(reachable);
  }

  void _set(bool online) {
    _recheck?.cancel();
    _recheck = online
        ? null
        : Timer.periodic(recheckInterval, (_) => refresh());
    if (online == _isOnline) return;
    _isOnline = online;
    if (!_controller.isClosed) _controller.add(online);
  }

  static Future<bool> defaultProbe() async {
    if (kIsWeb) return true;
    try {
      final result = await InternetAddress.lookup(
        'firestore.googleapis.com',
      ).timeout(const Duration(seconds: 4));
      return result.isNotEmpty && result.first.rawAddress.isNotEmpty;
    } catch (_) {
      return false;
    }
  }

  Future<void> dispose() async {
    _recheck?.cancel();
    await _subscription?.cancel();
    await _controller.close();
  }
}

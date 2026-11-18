import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/services/NetworkStatus.dart';

enum NetworkBannerStatus { online, offline, restored }

class NetworkStatusCubit extends Cubit<NetworkBannerStatus> {
  NetworkStatusCubit({
    required NetworkStatus network,
    this.restoredDuration = const Duration(seconds: 3),
  }) : super(
         network.isOnline
             ? NetworkBannerStatus.online
             : NetworkBannerStatus.offline,
       ) {
    _subscription = network.changes.listen(_onChange);
  }

  final Duration restoredDuration;
  StreamSubscription<bool>? _subscription;
  Timer? _restoredTimer;

  void _onChange(bool online) {
    _restoredTimer?.cancel();
    if (!online) {
      emit(NetworkBannerStatus.offline);
      return;
    }
    if (state != NetworkBannerStatus.offline) return;
    emit(NetworkBannerStatus.restored);
    _restoredTimer = Timer(restoredDuration, () {
      if (!isClosed && state == NetworkBannerStatus.restored) {
        emit(NetworkBannerStatus.online);
      }
    });
  }

  @override
  Future<void> close() async {
    _restoredTimer?.cancel();
    await _subscription?.cancel();
    return super.close();
  }
}

import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Whether the device currently reports a network path.
///
/// Offline-first screens should keep working; only generation / upload
/// surfaces should surface this as a banner.
enum NetworkReachability { online, offline, unknown }

abstract interface class ConnectivityStatus {
  Future<NetworkReachability> current();

  Stream<NetworkReachability> watch();
}

final class PlatformConnectivityStatus implements ConnectivityStatus {
  PlatformConnectivityStatus({Connectivity? connectivity})
    : _connectivity = connectivity ?? Connectivity();

  final Connectivity _connectivity;

  @override
  Future<NetworkReachability> current() async {
    final results = await _connectivity.checkConnectivity();
    return _map(results);
  }

  @override
  Stream<NetworkReachability> watch() {
    return _connectivity.onConnectivityChanged.map(_map);
  }

  NetworkReachability _map(List<ConnectivityResult> results) {
    if (results.isEmpty) {
      return NetworkReachability.unknown;
    }
    if (results.every((result) => result == ConnectivityResult.none)) {
      return NetworkReachability.offline;
    }
    return NetworkReachability.online;
  }
}

/// Fixed reachability for widget and unit tests.
final class FakeConnectivityStatus implements ConnectivityStatus {
  FakeConnectivityStatus(this._value);

  NetworkReachability _value;
  final _controller = StreamController<NetworkReachability>.broadcast();

  void set(NetworkReachability value) {
    _value = value;
    _controller.add(value);
  }

  @override
  Future<NetworkReachability> current() async => _value;

  @override
  Stream<NetworkReachability> watch() => _controller.stream;
}

final connectivityStatusProvider = Provider<ConnectivityStatus>(
  (ref) => PlatformConnectivityStatus(),
);

final networkReachabilityProvider = StreamProvider<NetworkReachability>((
  ref,
) async* {
  final status = ref.watch(connectivityStatusProvider);
  yield await status.current();
  yield* status.watch();
});

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:pb_ms_riverpod_sample/viewmodel/managed_app_config_viewmodel.dart';

final imanagedAppConfigProvider = Provider<Map<String, dynamic>?>((ref) {
  throw UnimplementedError();
});

final managedAppConfigProvider = Provider<ManagedAppConfig>((ref) {
  final mac = ref.watch(imanagedAppConfigProvider);
  return ManagedAppConfig(managedAppConfig: mac);
});

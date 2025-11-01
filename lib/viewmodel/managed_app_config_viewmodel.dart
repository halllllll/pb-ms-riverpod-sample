// viewmodel（ビジネスロジックと状態管理）は、riverpodを使ったMVVMの場合はNotifierをつくる
// 関数だけの場合は Provider をつくる
// ビジネスロジック部分はserviceにわけることもある？

class ManagedAppConfig {
  ManagedAppConfig({required this.managedAppConfig});
  final Map<String, dynamic>? managedAppConfig;

  String pick(String key) {
    return managedAppConfig![key]?.toString().trim() ?? "";
  }
}

// viewmodel（ビジネスロジックと状態管理）は、riverpodを使ったMVVMの場合は Notifier （状態を保つ場合）もしくは Provider (状態を持たない場合) をつくる
// * ここでは SharedPreferences への読み書きをするだけのクラスだが、 Preferences を Provider に登録してその Provider を使っている
// ビジネスロジック部分はserviceにわけることもある？

import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  Preferences({required this.sharedPreferences});

  final SharedPreferences sharedPreferences;

  void setValue({required String key, required String value}) {
    sharedPreferences.setString(key, value);
  }

  // どうしても Future が必要な場合用
  // ex) pocketbase で認証状態を永続化させるために AsyncAuthStore を使うが、
  // save プロパティが Future<void> 型なので、無意味だがFutureをつけている
  Future<void> setValueAsync({
    required String key,
    required String value,
  }) async {
    await sharedPreferences.setString(key, value);
  }

  String? getValue({required String key}) {
    return sharedPreferences.getString(key);
  }
}

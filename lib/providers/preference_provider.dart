import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pb_ms_riverpod_sample/viewmodel/preference_viewmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

// provider に登録
final iprefsProvider = Provider<SharedPreferences>((ref) {
  // 初期化時に上書きする
  throw UnimplementedError();
});

final prefsProvider = Provider<Preferences>((ref) {
  final prefs = ref.watch(iprefsProvider);
  return Preferences(sharedPreferences: prefs);
});

import 'package:pb_ms_riverpod_sample/viewmodel/auth_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocketbase/pocketbase.dart';

// provider に登録
final authProvider = NotifierProvider<AuthNotifier, RecordAuth?>(() {
  return AuthNotifier();
});

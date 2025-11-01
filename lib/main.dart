import 'package:flutter/material.dart';
import 'package:managed_configurations/managed_configurations.dart';
import 'package:pb_ms_riverpod_sample/providers/managed_app_provider.dart';
import 'package:pb_ms_riverpod_sample/providers/preference_provider.dart';

import 'package:pb_ms_riverpod_sample/views/home.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();
  final mac = ManagedConfigurations();
  final macMap = await mac.getManagedConfigurations;
  runApp(
    ProviderScope(
      overrides: [
        iprefsProvider.overrideWithValue(sharedPreferences),

        imanagedAppConfigProvider.overrideWithValue(macMap),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: Home());
    // return const MaterialApp(home: MyPage());
  }
}

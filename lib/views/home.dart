import 'package:flutter/material.dart';
import 'package:pb_ms_riverpod_sample/providers/auth_provider.dart';
import 'package:pb_ms_riverpod_sample/providers/managed_app_provider.dart';
import 'package:pb_ms_riverpod_sample/views/login_view.dart';
import 'package:pb_ms_riverpod_sample/views/user_info_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authProvider);
    final authNotifier = ref.read(authProvider.notifier);
    final mac = ref.read(managedAppConfigProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('PocketBase Auth With Microsoft Provider Demo'),
      ),
      body: Container(
        margin: const EdgeInsets.all(40),
        child: Center(
          child: mac.pick("pb_endpoint") == ""
              ? const Center(
                  child: Text(
                    "managed app configuration の値が設定されてません",
                    style: TextStyle(fontSize: 30),
                  ),
                )
              : auth == null
              ? LoginView(authNotifier: authNotifier)
              : UserInfoView(record: auth, authNotifier: authNotifier),
        ),
      ),
    );
  }
}

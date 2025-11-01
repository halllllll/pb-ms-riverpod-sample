import 'package:flutter/material.dart';
import 'package:pb_ms_riverpod_sample/viewmodel/auth_viewmodel.dart';

class LoginView extends StatelessWidget {
  final AuthNotifier authNotifier;
  const LoginView({super.key, required this.authNotifier});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Microsoft アカウントでログイン', style: TextStyle(fontSize: 18)),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () async {
            try {
              await authNotifier.login();
            } catch (e) {
              debugPrint("⚠️ Login error: ${e.toString()}");
            }
          },
          child: const Text("ログイン"),
        ),
      ],
    );
  }
}

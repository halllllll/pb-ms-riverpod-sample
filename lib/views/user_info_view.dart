import 'package:flutter/material.dart';
import 'package:pb_ms_riverpod_sample/viewmodel/auth_viewmodel.dart';
import 'package:pocketbase/pocketbase.dart';

class UserInfoView extends StatelessWidget {
  // final UserModel user;
  final AuthNotifier authNotifier;
  final RecordAuth record;
  const UserInfoView({
    super.key,
    // required this.user,
    required this.record,
    required this.authNotifier,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'ユーザー情報',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        buildInfoRow('ID', record.record.id),
        buildInfoRow('Email', record.record.get("email")),
        buildInfoRow('Name', record.record.get("name")),
        const SizedBox(height: 30),
        Center(
          child: ElevatedButton(
            onPressed: authNotifier.logout,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text("ログアウト"),
          ),
        ),
      ],
    );
  }

  Widget buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}

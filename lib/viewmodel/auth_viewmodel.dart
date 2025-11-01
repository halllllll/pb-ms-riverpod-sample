// viewmodel（ビジネスロジックと状態管理）は、riverpodを使ったMVVMの場合はNotifierをつくる
// ビジネスロジック部分はserviceにわけることもある？

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pb_ms_riverpod_sample/providers/managed_app_provider.dart';
import 'package:pb_ms_riverpod_sample/providers/preference_provider.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:url_launcher/url_launcher.dart';

class AuthNotifier extends Notifier<RecordAuth?> {
  late final PocketBase _pb;

  @override
  RecordAuth? build() {
    _initializePocketBase();
    // AuthStoreから現在の認証状態を取得
    if (_pb.authStore.isValid && _pb.authStore.record != null) {
      return RecordAuth(
        token: _pb.authStore.token,
        record: _pb.authStore.record!,
      );
    }
    return null;
  }

  void _initializePocketBase() {
    final prefs = ref.watch(prefsProvider);
    final mac = ref.watch(managedAppConfigProvider);

    final store = AsyncAuthStore(
      save: (String data) => prefs.setValueAsync(key: "pb_auth", value: data),
      initial: prefs.getValue(key: "pb_auth"),
    );
    _pb = PocketBase(mac.pick("pb_endpoint"), authStore: store);
  }

  Future<void> login() async {
    state = null;
    try {
      final result = await _pb.collection("users").authWithOAuth2("microsoft", (
        url,
      ) async {
        url = url.replace(
          queryParameters: {
            ...url.queryParameters,
            "prompt": "select_account",
            "scope": const [
              "User.Read",
              "email",
              "offline_access",
              "openid",
              "profile",
            ].join(' '),
          },
        );

        if (await canLaunchUrl(url)) {
          await launchUrl(url);
        }
      });

      state = result;
    } catch (e) {
      throw Exception("ログインに失敗しました: $e");
    } finally {
      /**
       * 公式サイトには次のようにあるが、
       * https://pocketbase.io/docs/authentication/#:~:text=vendor%20url%20to%20authenticate,app%20and%20realtime%20connection%20to
        
        > This method initializes a one-off realtime subscription and will
        > call the provided urlCallback with the OAuth2 vendor url to authenticate.
        > Once the external OAuth2 sign-in/sign-up flow is completed, the browser
        > window will be automatically closed and the OAuth2 data sent back
        > to the user through the previously established realtime connection.
        > or use flutter_custom_tabs to make the transitions between native and web content more seamless
      
       *  なんか自分の環境だと認証成功 or 失敗画面が閉じなかったので、明示的に閉じるようにする
       * 
       */
      await closeInAppWebView();
    }
  }

  void logout() {
    _pb.authStore.clear();
    state = null;
  }
}

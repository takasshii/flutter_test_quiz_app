import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginModel extends ChangeNotifier {
  String? mail;
  String? storedMail;
  final mailController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  //Controllerに反映
  SettingModel(user) {
    mailController.text = user!.name;
    mail = user.mail;
  }

  void setMail(String mail) {
    this.mail = mail;
    notifyListeners();
  }

  bool isUpdated() {
    return (mail != null);
  }

  Future login() async {
    if (mail == null) {
      throw ('メールアドレスを入力してください');
    }
  }

  final googleLogin = GoogleSignIn(scopes: [
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ]);

  void googleSignIn() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;
  }

  //ここからemailLink
  final ActionCodeSettings _setting = ActionCodeSettings(
    androidPackageName: 'com.example.flutter_test_takashii',
    // アプリのリリースバージョン指定。どんなバージョンでもアプリにリンクするよう'0'を指定
    androidMinimumVersion: '0',
    androidInstallApp: true,
    handleCodeInApp: true,
    iOSBundleId: 'com.example.2022flutterTestAppForMidwifeStudent',
    url: 'https://testAppForMidwifeStudents.page.link/emailLink',
  );

  late final EmailStore _emailStore;
  User? user;

  Future<void> initAsync(BuildContext context) async {
    await _initAuth();
    await _initEmail();
    await _initDynamicLink(context);
  }

  Future<void> _initAuth() async {
    _auth.userChanges().listen((event) {
      user = event;
    });
  }

  Future<void> _initEmail() async {
    _emailStore = EmailStore(await SharedPreferences.getInstance());

    // メールリンクの送信後、アプリで入力したメールアドレスをEmailStoreに保持している
    // このメールアドレスを利用して、メールリンクに含まれるものとアプリで入力したものが一致することを確認
    _emailStore.get().then((value) {
      storedMail = value;
    });
  }

  Future<void> _initDynamicLink(BuildContext context) async {
    // リンクからアプリへ遷移するとき、アプリが開いていると発動
    FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) {
      _verifyDynamicLink(dynamicLinkData, context);
      (e) async {
        ScaffoldSnackBar.of(context)
            .show('Error signing in with email link $e');
      };
    });

    // リンクからアプリへ遷移するとき、アプリが開いていないと発動
    FirebaseDynamicLinks.instance.getInitialLink().then((_) {
      _verifyDynamicLink(null, context);
    });
  }

  /// メールリンクの検証にのみ利　再ログイン時
  Future<dynamic> _verifyDynamicLink(
      PendingDynamicLinkData? _data, BuildContext context) async {
    // すでにSigninしている場合はスキップ
    if (user != null) return;
    // メールアドレスの入力がない場合はスキップ
    if (mail == null) return;

    final String? _deepLink = _data?.link.toString();
    if (_deepLink == null) return;

    // リンク（＝URL）が、メールリンクかどうか検証
    if (_auth.isSignInWithEmailLink(_deepLink)) {
      // メールリンクに含まれる認証情報でサインイン
      // 成功したらFirebase Authenticationにユーザーを作成（すでに存在する場合はログインのみ）
      _auth.signInWithEmailLink(email: mail!, emailLink: _deepLink).then(
        (value) async {
          ScaffoldSnackBar.of(context)
              .show('Successfully signed in! by: ${value.user!.email!}');
        },
      ).catchError(
        (onError) {
          ScaffoldSnackBar.of(context)
              .show('Error signing in with email link $onError');
        },
      );
    }
  }

  Future<void> register(BuildContext context) async {
    final String _email = mailController.text;
    _auth
        .sendSignInLinkToEmail(
      email: _email,
      actionCodeSettings: _setting,
    )
        .then(
      (_) async {
        // メールリンクの送信に成功したあと、メールアドレスをEmailStoreに保存
        _emailStore.set(_email).then((_) {
          storedMail = _email;
        });
        ScaffoldSnackBar.of(context)
            .show("Successfully send sign in email link!");
      },
    ).catchError(
      (onError) {
        ScaffoldSnackBar.of(context)
            .show('Error send sign in email link $onError');
      },
    );
  }

  Future<void> retry() async {
    // メールアドレスの保存を取消し、再度フォーム画面を表示
    _emailStore.clear().then((_) {
      storedMail = null;
    });
  }
}

class EmailStore {
  EmailStore(this._prefs);

  final SharedPreferences _prefs;

  Future<String?> get() async {
    return _prefs.getString("email");
  }

  Future<void> set(String email) async {
    await _prefs.setString("email", email);
  }

  Future<void> clear() async {
    await _prefs.remove("email");
  }
}

/// コード簡略化のためクラス化
class ScaffoldSnackBar {
  ScaffoldSnackBar(this._context);

  final BuildContext _context;

  factory ScaffoldSnackBar.of(BuildContext context) {
    return ScaffoldSnackBar(context);
  }

  void show(String message) {
    ScaffoldMessenger.of(_context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text(message)),
      );
  }
}

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_takashii/controllers/continuous_days_update_controller.dart';
import 'package:flutter_test_takashii/repository/ad_state.dart';
import 'package:flutter_test_takashii/screens/books/book_lists.dart';
import 'package:flutter_test_takashii/screens/welcome/welcome_screen.dart';
import 'package:flutter_test_takashii/signUp/sign_up_model.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final initFuture = MobileAds.instance.initialize();
  final adState = AdState(initFuture);
  await Firebase.initializeApp();
  runApp(Provider.value(
    value: adState,
    builder: (context, child) => MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<IsFirstLogin>(
      create: (_) => IsFirstLogin()..isFirstLoginFun(),
      child: Consumer<IsFirstLogin>(builder: (context, model, child) {
        final bool? _isFirstLogin = model.isFirstLogin;
        if (_isFirstLogin == null) {
          return Center(child: CircularProgressIndicator());
        }
        return MaterialApp(
          title: 'Quiz App',
          debugShowCheckedModeBanner: false,
          theme: ThemeData.light(),
          home: RootPage(isFirstLogin: _isFirstLogin),
        );
      }),
    );
  }
}

class RootPage extends StatelessWidget {
  const RootPage({Key? key, required this.isFirstLogin}) : super(key: key);
  final bool isFirstLogin;

  @override
  Widget build(BuildContext context) {
    if (isFirstLogin == false) {
      SignUpModel().signUpModel();
      return WelcomeScreen();
    } else {
      ContinuousDaysUpdate().LoginCheck();
      return BookList();
    }
  }
}

//初回ログインか判定する
class IsFirstLogin extends ChangeNotifier {
  bool? _isFirstLogin;
  bool? isFirstLogin;

  Future<void> isFirstLoginFun() async {
    // Obtain shared preferences.
    final prefs = await SharedPreferences.getInstance();
    _isFirstLogin = prefs.getBool('isFirstLogin');
    if (_isFirstLogin == true) {
      isFirstLogin = true;
    } else {
      isFirstLogin = false;
    }
    notifyListeners();
  }
}

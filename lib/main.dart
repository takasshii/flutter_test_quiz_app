import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_takashii/screens/welcome/welcome_screen.dart';
import 'package:flutter_test_takashii/signUp/sign_up_model.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: RootPage(),
    );
  }
}

class RootPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SignUpModel>(
      create: (_) => SignUpModel(),
      child: Consumer<SignUpModel>(builder: (context, model, child) {
        UserCredential? _userCredential =
            context.watch<SignUpModel>().userCredential;
        if (_userCredential == null) {
          model.login();
          return WelcomeScreen();
        } else {
          print("logged in");
          return WelcomeScreen();
        }
      }),
    );
  }
}

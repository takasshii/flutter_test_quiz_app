import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_takashii/controllers/continuous_days_update_controller.dart';
import 'package:flutter_test_takashii/screens/welcome/welcome_screen.dart';
import 'package:flutter_test_takashii/signUp/sign_up_model.dart';
import 'package:provider/provider.dart';

import 'domain/learning_data_get.dart';

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
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SignUpModel>(create: (_) => SignUpModel()),
        ChangeNotifierProvider<ContinuousDaysUpdate>(
            create: (_) => ContinuousDaysUpdate()..fetchLearningDataList()),
      ],
      child: Consumer<SignUpModel>(builder: (
        context,
        model,
        child,
      ) {
        //アカウントがない場合は作成
        if (currentUser == null) {
          model.login(currentUser);
          FirebaseAuth.instance.userChanges().listen((User? user) {
            if (user != null) {
              model.userCreate();
              model.userLocalCreate();
            }
          });
          return WelcomeScreen();
          //アカウントがある場合は、ログイン処理と学習日数の更新を行う。
        }
        return Consumer<ContinuousDaysUpdate>(builder: (
          context,
          model,
          child,
        ) {
          final LearningDataGet? learningData = model.learningDateList;
          if (learningData == null) {
            return Center(child: CircularProgressIndicator());
          }
          //ログインの日程が異なる場合のみトリガーが発動
          final bool isSameDay =
              learningData.updatedAt.difference(DateTime.now()).inDays != 0;
          if (isSameDay == false) {
            model.UpdateContinuousDaysUpdate(learningData);
          }
          return WelcomeScreen();
        });
      }),
    );
  }
}

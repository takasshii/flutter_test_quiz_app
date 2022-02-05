import 'package:flutter/material.dart';
import 'package:flutter_test_takashii/constants.dart';
import 'package:flutter_test_takashii/screens/quiz/quiz_screen.dart';
import 'package:websafe_svg/websafe_svg.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            width: size.width,
            height: size.height,
            child: WebsafeSvg.asset("assets/icons/bg.svg", fit: BoxFit.fill),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Spacer(flex: 2),
                  Text(
                    "Let's Play Quiz",
                    style: Theme.of(context).textTheme.headline4?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Text("Enter your information below"),
                  Spacer(),
                  TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xFF1C2341),
                      hintText: "Full Name",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                    ),
                  ),
                  Spacer(),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => QuizScreen()),
                      );
                    },
                    child: Container(
                      width: size.width,
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(kDefaultPadding * 0.75),
                      decoration: BoxDecoration(
                          gradient: kPrimaryGradient,
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                      child: Text(
                        "Let's Start Quiz",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  Spacer(flex: 2),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

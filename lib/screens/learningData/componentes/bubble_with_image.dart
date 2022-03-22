import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_takashii/controllers/conversation_controller.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';

class BubbleWithImage extends StatelessWidget {
  const BubbleWithImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final double height = size.width * 0.23;
    return ChangeNotifierProvider<ConversationController>(
      create: (_) => ConversationController()..randConversation(),
      child: Container(
        width: size.width - 40,
        child: InkWell(
          onTap: () {
            ConversationController().randConversation();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Bubble(
                  color: kBackGroundColor,
                  nip: BubbleNip.rightBottom,
                  child: Consumer<ConversationController>(
                      builder: (context, model, child) {
                    final String? conversation = model.conversation;
                    if (conversation == "") {
                      return Center(child: CircularProgressIndicator());
                    }
                    return Text(
                      conversation!,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: height / 6,
                          color: kGrayColor),
                    );
                  }),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  left: kDefaultPadding / 2,
                  bottom: kDefaultPadding,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: kGrayColor.withOpacity(0.3)),
                  borderRadius: BorderRadius.circular(50),
                ),
                //写真のサイズを固定
                width: size.width * 0.2,
                height: size.width * 0.2,
                child: Image.asset(
                  "assets/images/エジプト神（イヌ型）.png",
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

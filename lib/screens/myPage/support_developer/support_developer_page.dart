import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../dataTransfer/components/text_with_dot.dart';
import 'model/support_developer_model.dart';

class SupportDeveloperPage extends StatelessWidget {
  const SupportDeveloperPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SupportDeveloperModel>(
      create: (_) => SupportDeveloperModel(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 1.0,
          toolbarHeight: 50,
          backgroundColor: kBackGroundColor,
          iconTheme: IconThemeData(color: kBlackColor),
          title: Text(
            "開発者を支援",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 16, color: kBlackColor),
          ),
        ),
        body: Container(
          child: SingleChildScrollView(
            child: Consumer<SupportDeveloperModel>(
                builder: (context, model, child) {
              return Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: kDefaultPadding, vertical: kDefaultPadding),
                    //Statusを取得
                    child: Column(
                      children: [
                        TextWithDot(text: "継続した開発のために、支援をお願いします。", dot: "・ "),
                        Padding(
                          padding:
                              const EdgeInsets.only(top: kDefaultPadding / 4),
                          child: TextWithDot(
                              text: "かなりの費用を負担して運営しています。", dot: "・"),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}

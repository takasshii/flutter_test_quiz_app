import 'package:flutter/material.dart';
import 'package:flutter_test_takashii/domain/user_get.dart';
import 'package:flutter_test_takashii/screens/myPage/models/my_page_model.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../setting/components/buildShowModalBottomSheet.dart';

class IconWithName extends StatelessWidget {
  const IconWithName({Key? key, required this.user}) : super(key: key);

  final UserGet user;

  @override
  Widget build(BuildContext context) {
    final myPageModel = Provider.of<MyPageModel>(context);
    Size size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () async {
            await showModalBottomSheet(
                    //モーダルの背景の色、透過
                    backgroundColor: Colors.transparent,
                    //ドラッグ可能にする（高さもハーフサイズからフルサイズになる様子）
                    isScrollControlled: true,
                    context: context,
                    builder: (BuildContext context) {
                      return BuildShowModalBottomSheet();
                    })
                .then((value) =>
                    value != null ? myPageModel.fetchUserList() : print(""));
          },
          child: Container(
            margin: EdgeInsets.only(
                bottom: kDefaultPadding, right: kDefaultPadding),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: kGrayColor.withOpacity(0.3)),
              borderRadius: BorderRadius.circular(50),
            ),
            //写真のサイズを固定
            width: size.width * 0.2,
            height: size.width * 0.2,
            child: Image.asset(
              "${user.image}",
              fit: BoxFit.contain,
            ),
          ),
        ),
        Container(
          height: size.width * 0.2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Spacer(),
              RichText(
                  text: TextSpan(
                children: [
                  TextSpan(
                      text: "${user.name}",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: kBlackColor)),
                  TextSpan(
                      text: " さん",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: kGrayColor)),
                ],
              )),
              RichText(
                text: TextSpan(
                  text: user.grade == 0 ? "学年未設定" : "${user.grade}回生",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: kGrayColor),
                ),
              ),
              Spacer(flex: 3),
            ],
          ),
        ),
      ],
    );
  }
}

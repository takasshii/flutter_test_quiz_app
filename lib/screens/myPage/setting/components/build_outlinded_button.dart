import 'package:flutter/material.dart';
import 'package:flutter_test_takashii/screens/myPage/my_page_screen.dart';
import 'package:flutter_test_takashii/screens/myPage/setting/models/setting_model.dart';
import 'package:provider/provider.dart';

import '../../../../constants.dart';

class BuildOutlinedButton extends StatelessWidget {
  const BuildOutlinedButton({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<SettingModel>(context, listen: false);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: kDefaultPadding),
      child: SizedBox(
        height: 40,
        width: 100,
        child: ElevatedButton(
          onPressed: model.isUpdated()
              ? () {
                  try {
                    model.userUpdate();
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => (MyPageScreen()),
                      ),
                    );
                    final snackBar = SnackBar(
                        backgroundColor: Colors.lightGreen,
                        content: Text("更新が完了しました"));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  } catch (e) {
                    final snackBar = SnackBar(
                        backgroundColor: kRedColor,
                        content: Text(e.toString()));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                }
              : () {
                  final snackBar = SnackBar(
                      backgroundColor: Colors.red,
                      content: Text("10文字以下で名前を入力してください"));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
          child: Text("${title}",
              style: TextStyle(color: kBlackColor, fontSize: 16)),
          style: ElevatedButton.styleFrom(
            primary: Colors.white,
            onPrimary: kGrayColor,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            side: BorderSide(color: kGrayColor),
          ),
        ),
      ),
    );
  }
}

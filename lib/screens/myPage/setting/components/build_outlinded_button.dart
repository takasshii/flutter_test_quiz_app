import 'package:flutter/material.dart';
import 'package:flutter_test_takashii/screens/myPage/setting/models/setting_model.dart';
import 'package:provider/provider.dart';

import '../../../../constants.dart';

class BuildOutlinedButton extends StatelessWidget {
  const BuildOutlinedButton({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    final snackBar =
        SnackBar(backgroundColor: Colors.red, content: Text("名前を入力してください"));
    final model = Provider.of<SettingModel>(context, listen: false);
    return SizedBox(
      height: 50,
      child: ElevatedButton(
        onPressed: model.isUpdated()
            ? () {
                model.userUpdate();
              }
            : () {
                //うまく起動しないので直す必要あり
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
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_test_takashii/domain/userGet.dart';
import 'package:flutter_test_takashii/screens/commonComponents/bottomNavigation/bottom_navigation_bar.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import 'components/build_outlinded_button.dart';
import 'models/setting_model.dart';

class SettingProfile extends StatelessWidget {
  const SettingProfile({Key? key, required this.user}) : super(key: key);

  final UserGet user;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ChangeNotifierProvider<SettingModel>(
      create: (_) => SettingModel(user),
      child: Scaffold(
        appBar: AppBar(
          elevation: 1.0,
          toolbarHeight: 50,
          backgroundColor: kBackGroundColor,
          iconTheme: IconThemeData(color: kBlackColor),
          title: Text(
            "設定",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 16, color: kBlackColor),
          ),
        ),
        body: Consumer<SettingModel>(builder: (context, model, child) {
          return SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.all(kDefaultPadding),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: kDefaultPadding / 2),
                        width: size.width / 4,
                        alignment: Alignment.center,
                        child: RichText(
                            text: TextSpan(
                                text: "お名前",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: kBlackColor))),
                      ),
                      SizedBox(width: kDefaultPadding),
                      EditName(),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: kDefaultPadding / 2),
                        width: size.width / 4,
                        alignment: Alignment.center,
                        child: RichText(
                            text: TextSpan(
                                text: "学年",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: kBlackColor))),
                      ),
                      EditGrade(),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: kDefaultPadding / 2),
                        alignment: Alignment.center,
                        width: size.width / 4,
                        child: RichText(
                            text: TextSpan(
                                text: "ランキング",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: kBlackColor))),
                      ),
                      EditOpen(),
                    ],
                  ),
                  BuildOutlinedButton(title: "完了"),
                ],
              ),
            ),
          );
        }),
        bottomNavigationBar: BuildBottomNavigationBar(),
      ),
    );
  }
}

class EditName extends StatelessWidget {
  const EditName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<SettingModel>(context);
    return Expanded(
      child: Container(
        height: 50,
        padding: EdgeInsets.only(top: kDefaultPadding / 2),
        child: TextFormField(
          controller: model.nameController,
          onChanged: (text) {
            model.setName(text);
          },
          keyboardType: TextInputType.name,
          style: TextStyle(color: kBlackColor),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(
                top: 0,
                bottom: 0,
                left: kDefaultPadding / 2,
                right: kDefaultPadding / 2),
            fillColor: kBackGroundColor,
            filled: true,
            labelStyle: TextStyle(
              color: kBlackColor,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    );
  }
}

class EditGrade extends StatelessWidget {
  const EditGrade({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<SettingModel>(context);
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(top: kDefaultPadding / 2),
        child: DropdownButton<int>(
            value: model.grade,
            items: [
              DropdownMenuItem(
                child: Text('1回生'),
                value: 1,
              ),
              DropdownMenuItem(
                child: Text('2回生'),
                value: 2,
              ),
              DropdownMenuItem(
                child: Text('3回生'),
                value: 3,
              ),
              DropdownMenuItem(
                child: Text('4回生'),
                value: 4,
              ),
              DropdownMenuItem(
                child: Text('既卒'),
                value: -1,
              ),
            ],
            onChanged: (value) {
              model.setGrade(value!);
              value == -1 ? model.graduation = true : model.graduation = false;
            }),
      ),
    );
  }
}

class EditOpen extends StatelessWidget {
  const EditOpen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<SettingModel>(context);
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(top: kDefaultPadding / 2),
        child: DropdownButton<bool>(
            value: model.open,
            items: [
              DropdownMenuItem(
                child: Text('非公開'),
                value: false,
              ),
              DropdownMenuItem(
                child: Text('公開'),
                value: true,
              ),
            ],
            onChanged: (value) {
              model.setOpen(value!);
            }),
      ),
    );
  }
}

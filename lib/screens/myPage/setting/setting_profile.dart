import 'package:flutter/material.dart';
import 'package:flutter_test_takashii/domain/userGet.dart';
import 'package:flutter_test_takashii/screens/commonComponents/bottomNavigation/bottom_navigation_bar.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import 'models/setting_model.dart';

class SettingProfile extends StatelessWidget {
  const SettingProfile({Key? key, required this.user}) : super(key: key);

  final UserGet user;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SettingModel>(
      create: (_) => SettingModel(user),
      child: Scaffold(
        appBar: AppBar(
          elevation: 1.0,
          toolbarHeight: 50,
          backgroundColor: kBackGroundColor,
          automaticallyImplyLeading: false,
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
                  EditName(),
                  EditGrade(),
                  EditOpen(),
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
    return Container(
      padding: EdgeInsets.only(top: kDefaultPadding),
      child: TextFormField(
        controller: model.nameController,
        onChanged: (text) {
          model.setName(text);
        },
        keyboardType: TextInputType.name,
        style: TextStyle(color: kBlackColor),
        decoration: InputDecoration(
          fillColor: kBackGroundColor,
          filled: true,
          labelText: 'お名前',
          labelStyle: TextStyle(
            color: kBlackColor,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
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
    return Container(
      padding: EdgeInsets.only(top: kDefaultPadding),
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
    );
  }
}

class EditOpen extends StatelessWidget {
  const EditOpen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<SettingModel>(context);
    return Container(
      padding: EdgeInsets.only(top: kDefaultPadding),
      child: DropdownButton<bool>(
          value: model.open,
          items: [
            DropdownMenuItem(
              child: Text('公開'),
              value: true,
            ),
            DropdownMenuItem(
              child: Text('非公開'),
              value: false,
            ),
          ],
          onChanged: (value) {
            model.setOpen(value!);
          }),
    );
  }
}

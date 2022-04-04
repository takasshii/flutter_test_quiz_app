import 'package:flutter/material.dart';

import '../../../../constants.dart';

class InputForm extends StatelessWidget {
  const InputForm(
      {Key? key,
      required this.hintText,
      required this.onChanged,
      required this.controller,
      required this.textInputType,
      this.iconButton,
      this.obscureText})
      : super(key: key);

  final String hintText;
  final void Function(dynamic) onChanged;
  final TextEditingController controller;
  final TextInputType textInputType;
  final IconButton? iconButton;
  final bool? obscureText;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: 50,
      margin: EdgeInsets.only(bottom: kDefaultPadding * 0.5),
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
              padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
              height: 50,
              decoration: BoxDecoration(
                color: kGrayColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 10),
                    blurRadius: 50,
                    color: kGrayColor.withOpacity(0.23),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: controller,
                      onChanged: (text) {
                        onChanged;
                      },
                      keyboardType: textInputType,
                      decoration: InputDecoration(
                        hintText: hintText,
                        hintStyle: TextStyle(
                          color: kPrimaryColor.withOpacity(0.7),
                        ),
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        suffixIcon: iconButton,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

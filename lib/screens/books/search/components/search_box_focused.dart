import 'package:flutter/material.dart';
import 'package:flutter_test_takashii/screens/books/search/model/search_box_model.dart';
import 'package:provider/provider.dart';

import '../../../../constants.dart';

class SearchBoxFocused extends StatelessWidget {
  const SearchBoxFocused({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<SearchBoxModel>(context, listen: false);
    return Container(
      margin: EdgeInsets.only(
          bottom: kDefaultPadding / 2, right: kDefaultPadding / 2),
      child: Row(
        children: [
          Expanded(
            child: Stack(
              children: [
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(
                        left: kDefaultPadding, right: kDefaultPadding / 2),
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
                      children: <Widget>[
                        Expanded(
                          child: TextFormField(
                            controller: model.searchController,
                            autofocus: true,
                            onChanged: (text) {
                              model.setKeywords(text.toString());
                            },
                            textInputAction: TextInputAction.search,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              hintText: "Search",
                              hintStyle: TextStyle(
                                color: kPrimaryColor.withOpacity(0.7),
                              ),
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                            ),
                          ),
                        ),
                        Icon(Icons.search),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              Spacer(flex: 8),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'キャンセル',
                  style: TextStyle(fontSize: 14, color: kBlackColor),
                ),
              ),
              Spacer(flex: 3),
            ],
          ),
        ],
      ),
    );
  }
}

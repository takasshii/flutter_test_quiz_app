import 'package:flutter/material.dart';
import 'package:flutter_test_takashii/screens/books/search/search_list_show.dart';

import '../../../constants.dart';

class SearchBox extends StatelessWidget {
  const SearchBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: kDefaultPadding * 0.5),
      child: GestureDetector(
        onTap: () async {
          //フォーカスを外す
          FocusScope.of(context).unfocus();
          //検索画面に0秒で移行する
          await Navigator.of(context).push(
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) {
                return SearchListShow();
              },
              transitionDuration: Duration(seconds: 0),
            ),
          );
        },
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
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        "Search",
                        style: TextStyle(
                            color: kPrimaryColor.withOpacity(0.7),
                            fontSize: 16),
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
    );
  }
}

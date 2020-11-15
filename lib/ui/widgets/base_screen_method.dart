import 'package:flutter/material.dart';
import 'package:flutter_earthquake_network/res/resources.dart';

import '../../localizations.dart';

class BaseScreenMethod extends StatelessWidget {
  final String title;
  final Widget iconMoreMenu;
  final Widget iconShare;
  final Widget body;

  BaseScreenMethod(
      {Key key, this.title, this.iconMoreMenu, this.iconShare, this.body})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        automaticallyImplyLeading: true,
        title: Text(
          Language.of(context).getText(title),
          style: TextStyle(fontSize: AppDimens.SIZE_23),
        ),
        actions: <Widget>[
          this.iconShare != null ? iconShare : SizedBox(),
          this.iconMoreMenu != null ? iconMoreMenu : SizedBox(),
        ],
      ),
      body: body,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_earthquake_network/localizations.dart';
import 'package:flutter_earthquake_network/res/resources.dart';
import 'package:flutter_earthquake_network/ui/widgets/base_screen_method.dart';
import 'package:flutter_earthquake_network/ui/widgets/widgets.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String valueDropDownMagniyude = 'All Magnitude';
  String valueDropCity = 'All City';
  List<String> dsMagniyude = <String>[
    'All Magnitude',
    '1.0 +',
    '2.0 +',
    '3.0 +',
    '4.0 +',
    '5.0 +',
    '6.0 +',
    '7.0 +'
  ];
  List<String> dsCity = <String>['All City', 'Ha noi', 'Cao bang', 'Hai Phong'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(
          Language.of(context).getText('search'),
          style: TextStyle(fontSize: AppDimens.SIZE_23),
        ),
        actions: <Widget>[
          PopMenu(isRefresh: false,),
        ],
        bottom: PreferredSize(
          preferredSize: new Size(20, 30),
          child: Container(
            padding: EdgeInsets.only(
                left: AppDimens.SIZE_30, right: AppDimens.SIZE_30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                DropdownButton<String>(
                  dropdownColor: Colors.blue,
                  value: valueDropCity,
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: AppColors.white,
                  ),
                  //iconSize: 24,
                  // elevation: 16,
                  style: TextStyle(
                      color: AppColors.white, fontSize: AppDimens.SIZE_18),
                  onChanged: (String newValue) {
                    setState(() {
                      valueDropCity = newValue;
                    });
                  },
                  items: dsCity.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                DropdownButton<String>(
                  dropdownColor: Colors.blue,
                  value: valueDropDownMagniyude,
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: AppColors.white,
                  ),
                  style: TextStyle(
                      color: AppColors.white, fontSize: AppDimens.SIZE_18),
                  onChanged: (String newValue) {
                    setState(() {
                      valueDropDownMagniyude = newValue;
                    });
                  },
                  items:
                      dsMagniyude.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

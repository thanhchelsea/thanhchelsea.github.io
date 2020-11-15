import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_earthquake_network/blocs/app_bloc.dart';
import 'package:flutter_earthquake_network/res/resources.dart';
import 'package:flutter_earthquake_network/ui/widgets/dialog_type.dart';
import 'package:flutter_earthquake_network/ui/widgets/widgets.dart';
import 'package:flutter_earthquake_network/utils/common.dart';
import 'package:flutter_earthquake_network/utils/ultils.dart';

import '../../localizations.dart';

// enum SingingCharacter { Normal, Statellite, Terrain, Hybird }

class MapSettingScreen extends StatelessWidget {
  _showCupertinoDialog(BuildContext context) {
    List<String> ds = ['Normal', 'Statellite', 'Terrain', 'Hybird'];
    showDialog(
      //barrierDismissible: false,// dong dialog khi cham ben ngoai man hinh
      context: context,
      builder: (BuildContext context) {
        return DialogType(ds, (typeMap) {
          print(typeMap +"dc chon");
          BlocProvider.of<AppBloc>(context).add(changeTypeMap(typeMap));
          Common.changTypeMap(typeMap);
        });
      },
    );
  }

  Widget itemSetting(String title, String description, BuildContext context) {
    return InkWell(
      onTap: () {
        _showCupertinoDialog(context);
      },
      child: Column(
        children: <Widget>[
          Container(
            width: DeviceUtil.getDeviceWidth(context),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: AppDimens.SIZE_15,
                  left: AppDimens.SIZE_15,
                  bottom: AppDimens.SIZE_30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    Language.of(context).getText(title),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: AppDimens.SIZE_20),
                  ),
                  Text(
                    description != null
                        ? Language.of(context).getText(description)
                        : "",
                    style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: AppDimens.SIZE_15),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BaseScreenMethod(
        title: "settings.maps",
        body: Container(
          width: DeviceUtil.getDeviceWidth(context),
          child: Column(
            children: <Widget>[
              Container(
                child: itemSetting("settings.map_type",
                    "settings.map_type_description", context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

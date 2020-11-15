import 'package:flutter/material.dart';
import 'package:flutter_earthquake_network/localizations.dart';
import 'package:flutter_earthquake_network/res/dimens.dart';
import 'package:flutter_earthquake_network/routes.dart';
import 'package:flutter_earthquake_network/ui/widgets/base_screen_method.dart';
import 'package:flutter_earthquake_network/utils/device.dart';

class SettingScreens extends StatelessWidget {
  Widget itemSetting(String title, String description, BuildContext context,String jumpScreen) {
    return InkWell(
      onTap: (){
        Navigator.pushNamed(context, jumpScreen);
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
                        fontWeight: FontWeight.bold, fontSize: AppDimens.SIZE_20),
                  ),
                  Text(
                    description != null
                        ? Language.of(context).getText(description)
                        : "",
                    style: TextStyle(
                        fontWeight: FontWeight.w300, fontSize: AppDimens.SIZE_15),
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
          title: "home.settings",
          body: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(top: AppDimens.SIZE_10),
              child: Column(
                children: <Widget>[
                  Container(
                    child: itemSetting("settings.notifications",
                        "settings.descriptionNoti", context,Routes.notificationSetting),
                  ),
                  Container(
                    child: itemSetting(
                        "settings.maps", "settings.descriptionMap", context,Routes.mapSettings),
                  ),
                  Container(
                    child: itemSetting(
                        "settings.sos", "settings.descriptionSOS", context,Routes.sosSettingsScreen),
                  ),
                  Container(
                    child: itemSetting("settings.other", "", context,Routes.notificationSetting),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}

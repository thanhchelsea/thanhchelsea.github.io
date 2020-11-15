import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_earthquake_network/blocs/blocs.dart';
import 'package:flutter_earthquake_network/localizations.dart';
import 'package:flutter_earthquake_network/res/resources.dart';
import 'package:flutter_earthquake_network/routes.dart';
import 'package:flutter_earthquake_network/ui/widgets/widgets.dart';
import 'package:flutter_earthquake_network/utils/ultils.dart';
class SOSSetingsScreen extends StatelessWidget {

  Widget itemSettingSOS(BuildContext context,String title,String des,String status,String jumpScreen){
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
                    des != null
                        ? Language.of(context).getText(des)
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
      body: BlocProvider<PhoneSetting>(
        create: (context)=>PhoneSetting(),
        child: BaseScreenMethod(
          title: "settings.sos",
          body: Container(
            margin: EdgeInsets.only(top: AppDimens.SIZE_10),
            child: Column(
              children: <Widget>[
                Container(
                  child: itemSettingSOS(context,"settings.sms","settings.smsdes","Enabled",Routes.sosSettingSMS),
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}

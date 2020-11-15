import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_earthquake_network/blocs/app_bloc.dart';
import 'package:flutter_earthquake_network/blocs/base_bloc/base.dart';
import 'package:flutter_earthquake_network/res/colors.dart';
import 'package:flutter_earthquake_network/res/dimens.dart';
import 'package:flutter_earthquake_network/ui/screens/screens.dart';
import 'package:flutter_earthquake_network/ui/widgets/widgets.dart';
import 'package:flutter_earthquake_network/utils/ultils.dart';
import '../../localizations.dart';
import '../../routes.dart';
import 'map_screen.dart';
import 'sos.dart';

import 'package:location/location.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}
class _HomeState extends State<Home>  with AutomaticKeepAliveClientMixin<Home> {
  final Location location = Location();
  @override
  bool get wantKeepAlive => true;

  Widget ItemMethod(
      Icon icon, String title, BuildContext context, String jumpScreen) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, jumpScreen);
        //    Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.only(top: 5, bottom: 5, left: AppDimens.SIZE_10),
        child: Row(
          children: <Widget>[
            icon,
            Container(
              margin: EdgeInsets.only(left: AppDimens.SIZE_30),
              child: Text(
                Language.of(context).getText(title),
                style: TextStyle(
                    fontSize: AppDimens.SIZE_20, fontWeight: FontWeight.w300),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      this._checkLocation();
    });

    //_checkLocation();
  }

  _checkLocation() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    //_locationData = await location.getLocation();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); //
    return BlocBuilder<AppBloc, BaseState>(builder: (context, state) {
      return DefaultTabController(
        length: 4,
        child: Scaffold(
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  child: Center(
                    child: Text(
                      Language.of(context).getText("app_name"),
                      style: TextStyle(
                          color: AppColors.white, fontSize: AppDimens.SIZE_20),
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                ),
                Container(
                  height: 3 * DeviceUtil.getDeviceHeight(context) / 5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ItemMethod(Icon(Icons.settings), "home.settings", context,
                          Routes.settingScreen),
                      ItemMethod(
                          Icon(
                            Icons.info,
                            color: AppColors.blue,
                          ),
                          "home.about",
                          context,
                          Routes.aboutscreen),
                      ItemMethod(
                          Icon(
                            Icons.help,
                            color: AppColors.orange,
                          ),
                          "home.faq",
                          context,
                          Routes.faqScreen),
                      ItemMethod(
                          Icon(
                            Icons.verified_user,
                            color: AppColors.green,
                          ),
                          "home.terms_and_conditions",
                          context,
                          Routes.termAndCondition),
                      ItemMethod(
                          Icon(
                            Icons.security,
                            color: AppColors.green,
                          ),
                          "home.privacy_policy",
                          context,
                          Routes.privacyPolicy),
                    ],
                  ),
                )
              ],
            ),
          ),
          appBar: AppBar(

            title: Text(
              Language.of(context).getText("app_name"),
              style: TextStyle(fontSize: AppDimens.SIZE_23),
            ),
            bottom: PreferredSize(
              preferredSize: new Size(20, 30),
              child: TabBar(
                isScrollable: false,
                indicatorWeight: 4,
                tabs: [
                  Tab(
                    child: Text(
                      Language.of(context).getText("home.map"),
                      style: TextStyle(fontSize: AppDimens.SIZE_18),
                    ),
                  ),
                  Tab(
                    child: Text(
                      Language.of(context).getText("home.alert"),
                      style: TextStyle(fontSize: AppDimens.SIZE_18),
                    ),
                  ),
                  Tab(
                    child: Text(
                      Language.of(context).getText("home.reports"),
                      //style: TextStyle(fontSize: AppDimens.SIZE_18),
                    ),
                  ),
                  Tab(
                    child: Text(
                      Language.of(context).getText("home.sos"),
                      style: TextStyle(fontSize: AppDimens.SIZE_18),
                    ),
                  ),
                ],
              ),
            ),
            // leading: InkWell(
            //   onTap: () {},
            //   child: Container( child: Icon(Icons.menu)),
            // ),
            actions: <Widget>[
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, Routes.searchScreen);
                },
                child: Icon(Icons.search),
              ),
              Container(
                margin: EdgeInsets.only(
                  left: AppDimens.SIZE_1,
                ),
                child: InkWell(
                  onTap: () {},
                  child: PopMenu(isRefresh: true,),
                ),
              )
            ],
          ),
          body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: [
              MapScreen(),
              Icon(Icons.directions_transit),
              Icon(Icons.directions_bike),
              SOS(),
            ],
          ),
        ),
      );
    });
  }
}

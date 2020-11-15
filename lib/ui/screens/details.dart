import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_earthquake_network/blocs/app_bloc.dart';
import 'package:flutter_earthquake_network/blocs/base_bloc/base.dart';
import 'package:flutter_earthquake_network/data/model/model.dart';
import 'package:flutter_earthquake_network/localizations.dart';
import 'package:flutter_earthquake_network/res/colors.dart';
import 'package:flutter_earthquake_network/res/dimens.dart';
import 'package:flutter_earthquake_network/ui/widgets/map_widget.dart';
import 'package:flutter_earthquake_network/ui/widgets/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share/share.dart';
import 'dart:ui' as ui;
import 'dart:typed_data';

import '../../routes.dart';

class Details extends StatefulWidget {
  EarthquakeModel earthquakeModel;

  Details({this.earthquakeModel});

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  static GlobalKey _globalKey = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Widget Overview(EarthquakeModel earthquakeModel) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, top: 16),
      child: Column(
        children: [
          _itemDetail('Time', earthquakeModel.time),
          SizedBox(
            height: AppDimens.SIZE_50,
          ),
          _itemDetail('Location', earthquakeModel.address),
          SizedBox(
            height: AppDimens.SIZE_50,
          ),
          _itemDetail(
              'Lat/Lon', '${earthquakeModel.lat}, ${earthquakeModel.lng}'),
          SizedBox(
            height: AppDimens.SIZE_50,
          ),
          _itemDetail('Magnitude', earthquakeModel.magnitude.toString()),
          SizedBox(
            height: AppDimens.SIZE_50,
          ),
          _itemDetail('Depth', earthquakeModel.depth.toString()),
          SizedBox(
            height: AppDimens.SIZE_50,
          ),
          _itemDetail('Risk Level', earthquakeModel.riskLevel.toString()),
        ],
      ),
    );
  }

  Widget _itemDetail(String title, String content) {
    return Row(
      children: [
        Text(
          title + ': ',
          style: TextStyle(
            fontSize: AppDimens.SIZE_18,
            color: AppColors.blue,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          content,
          style: TextStyle(
            fontSize: AppDimens.SIZE_18,
          ),
        )
      ],
    );
  }

  _onShare(BuildContext context) async {
    List<String> list;
    final RenderBox box = context.findRenderObject();
    await Share.share('https://pub.dev/packages/share/example',
        subject: 'URL File Share',
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }

  @override
  Widget build(BuildContext context) {
    List<EarthquakeModel> list = new List<EarthquakeModel>();
    widget.earthquakeModel = new EarthquakeModel(
      address: 'Ha Noi',
      magnitude: 4.0,
      lat: 21.019531,
      lng: 105.848808,
      time: "1 hour ago",
      depth: 1000,
      riskLevel: 4,
    );
    list.add(widget.earthquakeModel);
    return BlocBuilder<AppBloc, BaseState>(
      builder: (context, state) {
        return DefaultTabController(
          length: 2,
          child: RepaintBoundary(
            key: _globalKey,
            child: Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: true,
                centerTitle: true,
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      widget.earthquakeModel.address,
                      style: TextStyle(
                          fontSize: AppDimens.SIZE_24,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      widget.earthquakeModel.time,
                      style: TextStyle(
                          fontSize: AppDimens.SIZE_14,
                          fontWeight: FontWeight.w200),
                    ),
                    //Text('goervnerovgerobnsh'),
                  ],
                ),
                actions: [
                  InkWell(
                    onTap: () {
                      _onShare(context);
                    },
                    child: Icon(Icons.share),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      left: AppDimens.SIZE_1,
                    ),
                    child: InkWell(
                      onTap: () {},
                      child: PopMenu(
                        isRefresh: true,
                      ),
                    ),
                  )
                ],
                bottom: PreferredSize(
                  preferredSize: new Size(20, 30),
                  child: TabBar(
                    isScrollable: false,
                    indicatorWeight: 2,
                    tabs: [
                      Tab(
                        child: Text(
                          Language.of(context).getText("details.map"),
                          style: TextStyle(fontSize: AppDimens.SIZE_18),
                        ),
                      ),
                      Tab(
                        child: Text(
                          Language.of(context).getText("details.overview"),
                          style: TextStyle(fontSize: AppDimens.SIZE_18),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              body: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: [
                  MapWidget(listMaker: list,cameraPosition: CameraPosition(
                    target: LatLng(widget.earthquakeModel.lat, widget.earthquakeModel.lng), // song gianh
                    zoom: 6,
                  ),),
                  Overview(widget.earthquakeModel),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

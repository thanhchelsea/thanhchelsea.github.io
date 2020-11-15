import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_earthquake_network/blocs/app_bloc.dart';
import 'package:flutter_earthquake_network/blocs/base_bloc/base.dart';
import 'package:flutter_earthquake_network/data/model/earthquake_model.dart';
import 'package:flutter_earthquake_network/ui/widgets/earthquake_item.dart';
import 'package:flutter_earthquake_network/ui/widgets/map_widget.dart';

import '../../constants.dart';

class MapScreen extends StatelessWidget  {
  MapScreen( );

  List<EarthquakeModel> list = new List<EarthquakeModel>();

  @override
  Widget build(BuildContext context) {
    list.add(new EarthquakeModel(address: 'Ha Noi', magnitude: 5.4, lat: 21.93, lng:104.66, time: "1 hour ago", depth: 1000, riskLevel: 4));
    list.add(new EarthquakeModel(address: 'Ha Noi', magnitude: 3.2, lat: 20.83, lng: 104.65, time: "2 hour ago", depth: 1300, riskLevel: 4));
    list.add(new EarthquakeModel(address: 'Ha Noi', magnitude: 3.7, lat: 22.575, lng:102.605, time: "1 hour 20 min ago", depth: 600, riskLevel: 4));
    list.add(new EarthquakeModel(address: 'Ha Noi', magnitude: 5.4, lat: 21.93, lng:104.66, time: "1 hour ago", depth: 1000, riskLevel: 4));
    list.add(new EarthquakeModel(address: 'Ha Noi', magnitude: 3.2, lat: 20.83, lng: 104.65, time: "2 hour ago", depth: 1300, riskLevel: 4));
    list.add(new EarthquakeModel(address: 'Ha Noi', magnitude: 3.7, lat: 22.575, lng:102.605, time: "1 hour 20 min ago", depth: 600, riskLevel: 4));

    return BlocBuilder<AppBloc,BaseState>(
      builder: (context, state) {
        return Column(
          children: [
            Expanded(
              flex: 5,
              child: MapWidget(listMaker: list,),
            ),
            //SizedBox(height: 5,),
            Expanded(
                flex: 5,
                child: Container(
                  color: Colors.white,
                  child: ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (BuildContext context, int index) {
                      return EarthquakeItem(list[index]);
                    },
                  ),
                )
            )
            //ListView()
          ],
        );
      },
    );
  }

}






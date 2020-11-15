import 'package:flutter/material.dart';
import 'package:flutter_earthquake_network/data/model/model.dart';
import 'package:flutter_earthquake_network/res/colors.dart';
import 'package:flutter_earthquake_network/res/dimens.dart';
import 'package:flutter_earthquake_network/utils/device.dart';

import '../../routes.dart';

class EarthquakeItem extends StatelessWidget {
  EarthquakeModel earthquakeModel;

  EarthquakeItem(this.earthquakeModel);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: Colors.white,
      onPressed: () {
        Navigator.pushNamed(context, Routes.earthquakeDetais);
      },
      child: Container(
        child: Column(
          children: [
            Container(
              padding:  EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      //color: Colors.red,
                      alignment: Alignment.center,
                      child: Icon(
                          Icons.menu
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 7,
                    child: Container(
                      //color: Colors.blue,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        earthquakeModel.address,
                        style: TextStyle(
                          fontSize: AppDimens.SIZE_18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        Container(
                          child: Text(
                            '${earthquakeModel.magnitude}',
                            style: TextStyle(
                                color: AppColors.white
                            ),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            color: Colors.red,
                          ),
                          padding: EdgeInsets.only(top: 2, bottom: 2, left: 5, right: 5),
                        ),
                        SizedBox(height: 5,),
                        Text(
                          earthquakeModel.time,
                          style: TextStyle(fontSize: AppDimens.SIZE_12, fontWeight: FontWeight.w200),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Divider(thickness: 1,)
          ],
        ),
      ),
    );
  }
}


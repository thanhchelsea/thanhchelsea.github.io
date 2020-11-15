import 'dart:async';
import 'dart:collection';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_earthquake_network/blocs/blocs.dart';
import 'package:flutter_earthquake_network/data/model/earthquake_model.dart';
import 'package:flutter_earthquake_network/ui/widgets/circle.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants.dart';

class MapWidget extends StatefulWidget {
  List<EarthquakeModel> listMaker = [];
  CameraPosition cameraPosition;
  MapWidget({this.listMaker,this.cameraPosition});

  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<MapWidget>
    with
        AutomaticKeepAliveClientMixin<MapWidget>,
        SingleTickerProviderStateMixin {
  @override
  bool get wantKeepAlive => true;
  Completer<GoogleMapController> _controller = Completer();
  MapType mapType;
  String typeMap;
  List<Marker> _ds = <Marker>[];
  Set<Circle> _dscir = HashSet<Circle>();
  static CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(17.712952, 106.442713), // song gianh
    zoom: 4.5,
  );

  Future getTypeMapShred() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    typeMap = preferences.get(SPrefCache.TYPE_MAP);
    switch (typeMap) {
      case "Normal":
        {
          setState(() {
            mapType = MapType.normal;
          });

          print(" da thay doi sang " + typeMap);
          break;
        }
      case "Statellite":
        {
          setState(() {
            mapType = MapType.satellite;
          });

          print(" da thay doi sang " + typeMap);
          break;
        }
      case "Terrain":
        {
          setState(() {
            mapType = MapType.terrain;
          });
          print(" da thay doi sang" + typeMap);
          break;
        }
      case "Hybird":
        {
          setState(() {
            mapType = MapType.hybrid;
          });
          print(" da thay doi sang" + typeMap);
          break;
        }
    }
  }

  // Future<Uint8List> getBytesFromCanvas(int width, int height) async {
  //   final PictureRecorder pictureRecorder = PictureRecorder();
  //   final Canvas canvas = Canvas(pictureRecorder);
  //   final Paint paint = Paint()..color = Colors.blue;
  //   final Radius radius = Radius.circular(width / 2);
  //
  //   SpritePainter a = new SpritePainter(_controller1);
  //   a.paint(canvas, Size(150, 150));
  //   final img = await pictureRecorder.endRecording().toImage(width, height);
  //   final data = await img.toByteData(format: ImageByteFormat.png);
  //   return data.buffer.asUint8List();
  // }

  Future<Uint8List> a() async {
    if(widget.cameraPosition!=null){
      _kGooglePlex=widget.cameraPosition;
    }

    //Uint8List markerIcon = await getBytesFromCanvas(300, 300);
    if (widget.listMaker != null) {
      //  print(widget.listMaker.length.toString() + " dfd");
      int a=0;
      for (EarthquakeModel e in widget.listMaker) {

        print("fd");
        _ds.add(Marker(
          //  icon: BitmapDescriptor.fromBytes(markerIcon),
            flat: true,
            markerId: MarkerId('1221'),
            position: LatLng(e.lat, e.lng),
            infoWindow: InfoWindow(
              title: e.address,
            )));
        _setCircles(a,e);
     //   print(_dscir.length.toString());
        a++;
      }
    }
  //  return markerIcon;
  }

  void _setCircles(id,EarthquakeModel e) {
    print(id.toString() +" dfdfdfd");
    _dscir.add(
      Circle(
          strokeColor: Colors.red,
          circleId: CircleId(id.toString()),
          center: LatLng(e.lat,e.lng),
          radius: 100000,
          strokeWidth: 2,
          fillColor: Color.fromRGBO(102, 51, 153, .5)),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _controller1 = new AnimationController(
    //   vsync: this,
    // );
   // _setCircles();
    a();
    getTypeMapShred();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AppBloc, BaseState>(
        listener: (context, state) {
          print(state.toString() + " sdfsdfsdfs");
          if (state is ChangeMap) {
            switch (state.Map) {
              case "Normal":
                {
                  mapType = MapType.normal;
                  print(" da thay doi " + state.Map);
                  break;
                }
              case "Statellite":
                {
                  mapType = MapType.satellite;
                  print(" da thay doi " + state.Map);
                  break;
                }
              case "Terrain":
                {
                  mapType = MapType.terrain;
                  print(" da thay doi " + state.Map);
                  break;
                }
              case "Hybird":
                {
                  mapType = MapType.hybrid;
                  print(" da thay doi " + state.Map);
                  break;
                }
            }
          }
        },
        child: Stack(
          children: <Widget>[
            GoogleMap(
              markers: _ds != null ? Set<Marker>.of(_ds) : null,
              myLocationEnabled: true,
              circles:_dscir!=null ?_dscir : Set<Circle>.of([
                Circle(
                    strokeColor: Colors.red,
                    circleId: CircleId("fgf"),
                    center: LatLng(21.93,104.66),
                    radius: 1000,
                    strokeWidth: 2,
                    fillColor: Color.fromRGBO(102, 51, 153, .5)),
              ]),
              mapType: mapType,
              zoomGesturesEnabled: true,
              onCameraMove: (p) {
                if (_ds.length > 0) {
                  MarkerId markerId = MarkerId("g");
                  Marker marker = _ds[0];
                  //  Marker updatedMarker =marker.infoWindow;

                  // setState(() {
                  //   _ds[0] = updatedMarker;
                  // });
                }
              },
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
          ],
        ),
      ),
    );
  }
}


import 'package:shared_preferences/shared_preferences.dart';
import 'package:location/location.dart';
import 'package:geocoder/geocoder.dart';
import 'package:flutter/services.dart';
import '../constants.dart';

class Common{
  static Future saveTypeLanguage(String language) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(SPrefCache.PREF_KEY_LANGUAGE, language);
  }

  static Future changTypeMap(String typeMap) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(SPrefCache.TYPE_MAP,typeMap);// doi map
  }

 static Future saveListPhone(List<String> dsPhone) async {
    // luu ds phone
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setStringList(SPrefCache.LIST_PHONE, dsPhone);
  }

 static Future<List<String>> getListPhone() async {
    // get ds phone
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> dsPhone=[];
    dsPhone=prefs.getStringList(SPrefCache.LIST_PHONE);
    return dsPhone;
  }

  static Future saveMessageSOS(String message) async{
    SharedPreferences prefs= await SharedPreferences.getInstance();
    return await prefs.setString(SPrefCache.MESSAGE_SOS, message);

  }
  static Future<String> getMessageSOS() async {
    // get ds phone
    SharedPreferences prefs = await SharedPreferences.getInstance();
   String messageSOS=  prefs.getString(SPrefCache.MESSAGE_SOS);
    return messageSOS;
  }


 static Future<Coordinates> getCoordinates() async
  {
    LocationData myLocation;
    Coordinates coordinates = new Coordinates(
        myLocation.latitude, myLocation.longitude);
    return coordinates;
  }
 static Future<String> getUserLocation() async {
    String locate="";String latlng="";
    LocationData myLocation;
    Location location = new Location();
    bool _serviceEnabled;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
    }
    if (_serviceEnabled) {
      try {
        myLocation = await location.getLocation();
        final coordinates = new Coordinates(
            myLocation.latitude, myLocation.longitude);
        var addresses = await Geocoder.local.findAddressesFromCoordinates(
            coordinates);
        var first = addresses.first;
         locate=first.addressLine;
         latlng="Latitude :"+first.coordinates.latitude.toString()+"\nLongitude :"+first.coordinates.longitude.toString();
          print(locate +latlng);
      }  catch (e) {
        if (e.code == 'PERMISSION_DENIED') {
         // error = 'please grant permission';
        }
        if (e.code == 'PERMISSION_DENIED_NEVER_ASK') {
          //error = 'permission denied- please enable it from app settings';print("sai2");
        }
        myLocation = null;
      }
    }
    return locate+"\n"+latlng;
  }


}
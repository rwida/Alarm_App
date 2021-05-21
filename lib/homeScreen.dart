import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
//import 'package:location/location.dart';
import 'package:http/http.dart' as http;

class homeScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return homeScreenState();
  }

}
class homeScreenState extends State<homeScreen>{
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      print("location 3");
      return Future.error(
          'Location permissions are permantly denied, we cannot request permissions.');
    }

    if (permission == LocationPermission.denied) {
      print("location 1");
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        print("location 2");
        return Future.error(
            'Location permissions are denied (actual value: $permission).');
      }
    }else{
      var loc = await Geolocator.getCurrentPosition();
      print(loc.toString());
    }
    // serviceEnabled = await Geolocator.isLocationServiceEnabled();
    // if (!serviceEnabled) {
    //   LocationPermission permission = await Geolocator.requestPermission();
    //   return Future.error('Location services are disabled.');
    // }

    return await Geolocator.getCurrentPosition();
  }
 void grtLoc() async {
   LocationPermission permission = await Geolocator.checkPermission();
   bool isLocationServiceEnabled  = await Geolocator.isLocationServiceEnabled();
   if(isLocationServiceEnabled == false){
     Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
     print(position.toString());
   }
    //Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print(permission.toString());
   print(isLocationServiceEnabled.toString());
   //print(position.toString());
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   // _determinePosition();
    //getLocation();
    grtLoc();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(child: Text("welcome mohamed nabil"),),
    );
  }

}
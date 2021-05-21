import 'dart:convert';
import 'package:geocoder/geocoder.dart';
import 'package:http/http.dart' as http;
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:superk_new/Deals.dart';
import 'package:superk_new/MapWithMarker.dart';
import 'package:superk_new/product_detail_page_linking.dart';
import 'package:superk_new/profile.dart';

import 'Genral.dart';


class user_location2 extends StatefulWidget {
  final String Page;
  user_location2({
    this.Page,
  });
  @override
  _UserLocationState createState() => _UserLocationState();
}

class _UserLocationState extends State<user_location2> {
  double _lat, _lng;
  _onLocationChange(lat, lng) {
    _lat = lat;
    _lng = lng;
  }

  back() async {
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    print("_lat is :$_lat and lng is $_lng");
    Map lanLng = {"lat": _lat, "lng": _lng};
    LoginAPI(_lat,_lng);
    // sharedPrefs.setString("lat", "$_lat");
    // sharedPrefs.setString("lng", "$_lng");
    // setState(() {
    //   Lat = _lat.toString();
    //   Long = _lng.toString();
    // });
    // Navigator.pushReplacement(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) => Deals(),
    //     ));
    // setState(() {
    //   FilterLong = _lng.toString();
    //   FilterLat = _lat.toString();
    // });
    //Navigator.pop(context);
    // Navigator.pop(context, lanLng);
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocation();
    initDynamicLinks();
    //handleDynamicLinks();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0.0,
        centerTitle: true,
        elevation: 1.0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20.0),
                bottomRight: Radius.circular(20.0))),
        backgroundColor: Colors.white,

        title: Image.asset("images/logo.png",width: 150,height: 80,),
        // leading: IconButton(
        //   onPressed: () {
        //     Navigator.of(context).pop();
        //   },
        //   icon: Icon(
        //     Icons.arrow_back_ios,
        //     color: Color(0xFFff8500),
        //   ),
        // ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(5.0),
          child: Container(),
        ),
      ),
      body: Stack(
        children: <Widget>[
          MapWithMarker(
            enableMyLocation: true,
            marker: Icon(
              Icons.location_on,
              color: Color(0xFF13446f),
              size: 60.0,
            ),
            onLocationChange: (double lng, double lat) {
              _onLocationChange(lng, lat);
            },
          ),
          Positioned(
            bottom: 20.0,
            left: 30.0,
            child: RaisedButton(
              color: Color(0xFFff8500),
              child: Text("Continue",style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500,color: Colors.white),),
              onPressed: () => back(),
            ),
          )
        ],
      ),
    );
  }

  LoginAPI(lat,lang) async {
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    // print("user id is ${sharedPrefs.getString('UserId')}");
    final coordinates = new Coordinates(double.parse("${lat}"), double.parse("${lang}"));
    var addresses =
    await Geocoder.google("AIzaSyB-zre1gZSbbXHdzyGeWNnjGRbtVFZYbNs").findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
// print number of retured addresses
    debugPrint('${addresses.length}');
// print the best address
    debugPrint("${first.featureName} : ${first.addressLine}");
    // setState(() {
    //   BRANCHES2.add(first.featureName.toString());
    //   // Address = first.featureName.toString();
    // });
    var d ={
      "customer_id":"${sharedPrefs.getString("UserId")}",
      "email":"${sharedPrefs.getString("email")}",
      "address":"${first.featureName.toString()}",
      "latitude":"${lat}",
      "longitude":"${lang}"
    };
    http.Response response = await http.post('http://wootc.net/api/customer_location/store',body: json.encode(d),headers: { "Accept":"application/json",'Content-type': 'application/json',});
    print(response.body.toString());
    var responsebody = json.decode(response.body);
    if(responsebody['Status'] == true){
      sharedPrefs.setInt("AddressId", responsebody['Customer Location']['id']);
      // sharedPrefs.setBool("login", true);
      // sharedPrefs.setString("name", "${responsebody['Customer']['name']}");
      // sharedPrefs.setString("email", "${responsebody['Customer']['email']}");
      // sharedPrefs.setString("phone", "${responsebody['Customer']['phone']}");
      // sharedPrefs.setString("address", "${responsebody['Customer']['address']}");
      // sharedPrefs.setString("UserId", "${responsebody['Customer']['id']}");
      // setState(() {
      //   Login = true;
      // });
      // return 'success';
      print("uuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuu");
      Navigator.pop(context);
      if(widget.Page == "Deals"){
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Deals()));
      }else{
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => profile()));
      }

    }else{
      print("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx");
      //return 'error';
    }
  }


  void initDynamicLinks() async {
    //var xx = await createDynamicLink(userName: "mohamed_nabil");
    // print("yourrrrrrrrrrrrrrrrrrr link is $xx");
    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData dynamicLink) async {
          final Uri deepLink = dynamicLink?.link;

          if (deepLink != null) {
            final queryParams = deepLink.queryParameters;
            if(queryParams.length > 0) {
              String userName = queryParams["username"];

              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductDetailPage_linking(id:int.parse(userName),),
                  ));
              // verify the username is parsed correctly
              print("My users username is: $userName");
            }else{
              print("$deepLink 55555555555555555555555555555555555555555555555");
            }
            //Navigator.pushNamed(context, deepLink.path);
            // print("${deepLink.query} 55555555555555555555555555555555555555555555555");
            // print("${deepLink.queryParameters['name']} 88888888888888888888888888888");
            // //print("${deepLink.queryParameters.keys} 55555555555555555555555555555555555555555555555");
            // //print("${deepLink.data.uri} 666666666666666666666666666");
            // print("${deepLink.origin} 77777777777777777777777777777777");
            // print("${deepLink.hasAuthority} 55555555555555555555555555555555555555555555555");
            // print("${deepLink.data} 55555555555555555555555555555555555555555555555");
            // print("${deepLink.queryParameters} 55555555555555555555555555555555555555555555555");
          }
        },
        onError: (OnLinkErrorException e) async {
          print('onLinkError');
          print(e.message);
        }

    );

    final PendingDynamicLinkData data = await FirebaseDynamicLinks.instance.getInitialLink();
    final Uri deepLink = data?.link;

    if (deepLink != null) {
      final queryParams = deepLink.queryParameters;
      if(queryParams.length > 0) {
        String userName = queryParams['username'];
        // verify the username is parsed correctly
        print("My users username is: $userName");
      }else{
        print("55555555555555555555555555555555555555555555555");
      }
      // print("${deepLink.query} 55555555555555555555555555555555555555555555555");
      // print("${deepLink.queryParameters['name']} 88888888888888888888888888888");
      // //print("${deepLink.data.uri} 6666666666666666666666");
      // print("${deepLink.origin} 77777777777777777777777777");
      // print("${deepLink.hasAuthority} 55555555555555555555555555555555555555555555555");
      // print("${deepLink.data.parameters} 55555555555555555555555555555555555555555555555");
      // print("${deepLink.queryParameters} 55555555555555555555555555555555555555555555555");
      //Navigator.pushNamed(context, deepLink.path);
    }
  }
  void getLocation() async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;
    _locationData = await location.getLocation();
    _serviceEnabled = await location.serviceEnabled();

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        print("NO Location Opend");
      }else{
        print("Location is Opend");

        // Long = _locationData.longitude;
        // Lat = _locationData.latitude;
        //
        // print(_locationData.latitude.toString());
        // print(_locationData.longitude.toString());
      }
    }
    // else{
    //   print("opend las");
    //
    //   Long = _locationData.longitude;
    //   Lat = _locationData.latitude;
    //
    //   print(_locationData.latitude.toString());
    //   print(_locationData.longitude.toString());
    // }
    // Navigator.pushReplacementNamed(context, "HomeScreen");
    // Position position = await Geolocator()
    //     .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    // print(position);
  }

  void handleDynamicLinks() async {
    ///To bring INTO FOREGROUND FROM DYNAMIC LINK.
    FirebaseDynamicLinks.instance.onLink(
      onSuccess: (PendingDynamicLinkData dynamicLinkData) async {
        await _handleDeepLink(dynamicLinkData);
      },
      onError: (OnLinkErrorException e) async {
        print('DynamicLink Failed: ${e.message}');
        return e.message;
      },
    );

    final PendingDynamicLinkData data =
    await FirebaseDynamicLinks.instance.getInitialLink();
    _handleDeepLink(data);
  }

  // bool _deeplink = true;
  _handleDeepLink(PendingDynamicLinkData data) async {

    final  deeplink = data.link;
    if (deeplink != null) {
      print('Handling Deep Link | deepLink: $deeplink');
    }
  }
}

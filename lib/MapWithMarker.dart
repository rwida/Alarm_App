import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:location/location.dart' as LocationManager;
import 'package:flutter/services.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:app_settings/app_settings.dart';

const kGoogleApiKey = "AIzaSyB-zre1gZSbbXHdzyGeWNnjGRbtVFZYbNs";

GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);

class MapWithMarker extends StatefulWidget {
  final Widget marker;
  final double mapHeight;
  final double mapWidth;
  final Function onLocationChange;
  final Function listenToCreatedMap;
  final Function checkErrorMapOccurFunc;
  final bool enableMyLocation;
  final bool showMyLocationButton;
  final double locationButtonPositionLeft;
  final double locationButtonPositionTop;
  final double locationButtonPositionRight;
  final double locationButtonPositionBottom;

  //it should be ordered this way: [long,lat]
  final List<dynamic> initialMapPosition;

  const MapWithMarker({
    this.marker,
    this.mapHeight,
    this.mapWidth,
    this.onLocationChange,
    this.showMyLocationButton = false,
    this.checkErrorMapOccurFunc,
    this.enableMyLocation = false,
    this.initialMapPosition,
    this.listenToCreatedMap,
    this.locationButtonPositionBottom = 24.0,
    this.locationButtonPositionLeft = 0.0,
    this.locationButtonPositionRight,
    this.locationButtonPositionTop,
  });

  @override
  State<MapWithMarker> createState() => MapWithMarkerState();
}

/*
* Usage example:
* MapWithMarker(mapWidth: MediaQuery.of(context).size.width,mapHeight: MediaQuery.of(context).size.height,marker: Icon(Icons.bookmark),),
* */
class MapWithMarkerState extends State<MapWithMarker> {
  Future<CameraPosition> _cameraInitialPosition;
  Completer<GoogleMapController> _controller = Completer();
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  final String markerIdVal = "MYMARKERID";
  String formattedAddress = "Search for stores";
  @override
  void initState() {
    super.initState();
    print("init map with marker");
    _initializeCamera();

    SystemChannels.lifecycle.setMessageHandler((msg) async {
      if (msg == AppLifecycleState.resumed.toString()) {
        setState(() {
          _initializeCamera();
        });
      }
    });
  }

  void _initializeCamera() {
    _cameraInitialPosition = widget.initialMapPosition != null
        ? _getInitialPosition()
        : _getUserLocation();

    if (widget.initialMapPosition != null) {
      final MarkerId markerId = MarkerId(markerIdVal);
      markers[markerId] = Marker(
        markerId: markerId,
        position: LatLng(double.parse(widget.initialMapPosition[1].toString()),
            double.parse(widget.initialMapPosition[0].toString())),
        infoWindow: InfoWindow(title: markerIdVal, snippet: '*'),
      );
    }
  }

  Future<CameraPosition> _getInitialPosition() async {
    return CameraPosition(
      target: LatLng(double.parse(widget.initialMapPosition[1].toString()),
          double.parse(widget.initialMapPosition[0].toString())),
      zoom: 10.0,
    );
  }

  Future<CameraPosition> _getUserLocation() async {
    LocationManager.LocationData currentLocation;
    var location = new LocationManager.Location();
    try {
      if (await location.serviceEnabled()) {
        currentLocation = await location.getLocation();
        if (await location.hasPermission() ==
            LocationManager.PermissionStatus.granted) {
          widget.onLocationChange(
              currentLocation.latitude, currentLocation.longitude);
          if (widget.checkErrorMapOccurFunc != null) {
            widget.checkErrorMapOccurFunc(isError: false);
          }

          return CameraPosition(
            target: LatLng(currentLocation.latitude, currentLocation.longitude),
            zoom: 14.4746,
          );
        } else {
          if (widget.checkErrorMapOccurFunc != null) {
            widget.checkErrorMapOccurFunc(isError: true);
          }

          throw Exception(
              ["Please turn on location permission for Ariees app1"]);
        }
      } else {
        if (widget.checkErrorMapOccurFunc != null) {
          widget.checkErrorMapOccurFunc(isError: true);
        }

        throw Exception(
            "Please turn on your location services to be able to serve you");
      }
    } catch (error) {
      print("an error occur");
      print('lol :${error.toString()}');
      widget.checkErrorMapOccurFunc(isError: true);
      location.requestPermission();
      throw Exception(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<CameraPosition>(
      future: _cameraInitialPosition,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Container(
            height: widget.mapHeight,
            width: widget.mapWidth,
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                GoogleMap(
                  markers: Set<Marker>.of(markers.values),
                  myLocationEnabled: widget.enableMyLocation,
                  mapType: MapType.normal,
                  myLocationButtonEnabled: false,
                  initialCameraPosition: snapshot.data,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                    if (widget.listenToCreatedMap != null) {
                      widget.listenToCreatedMap();
                    }
                  },
                  onCameraMove: (CameraPosition newPosition) {
                    widget.onLocationChange(newPosition.target.latitude,
                        newPosition.target.longitude);
                  },
                ),
                widget.marker != null
                    ? Positioned(
                  left: 0.0,
                  right: 0.0,
                  bottom: 0.0,
                  top: 0.0,
                  child: Align(
                    alignment: Alignment.center,
                    child: widget.marker,
                  ),
                )
                    : Container(),
                Positioned(
                  top: widget.locationButtonPositionTop,
                  right: widget.locationButtonPositionRight,
                  left: widget.locationButtonPositionLeft,
                  bottom: widget.locationButtonPositionBottom,
                  child: widget.showMyLocationButton
                      ? RaisedButton(
                    onPressed: _gotoMyLocation,
                    color: Colors.white,
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(12.0),
                    child: Icon(
                      Icons.my_location,
                      size: 24.0,
                    ),
                  )
                      : Container(),
                ),
                Positioned(
                  left: 15.0,
                  right: 15.0,
                  top: 20,
                  child: handleSearchBtn(),
                )
              ],
            ),
          );
        } else if (snapshot.hasError) {
          print(snapshot.error);
          return Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(snapshot.error
                    .toString()
                    .replaceAll("Exception", "")
                    .replaceAll(":", "")),
                RaisedButton(
                  onPressed: () {
                    AppSettings.openLocationSettings();
                  },
                  child: Text("Go To Location Settings"),
                )
              ],
            ),
          );
        }
        return Container();
      },
    );
  }

  Future<LatLng> getUserLocation2() async {
    LocationManager.LocationData currentLocation;
    var location = new LocationManager.Location();
    currentLocation = await location.getLocation();
    print("currentLocation :$currentLocation");
    try {
      final center =
      LatLng(currentLocation.latitude, currentLocation.longitude);
      print("center is :$center");
      return center;
    } on Exception {
      currentLocation = null;
      return null;
    }
  }

  openPlacesScreen() async {
    try {
      final center = await getUserLocation2();
      print("lol center :$center");
      Prediction p = await PlacesAutocomplete.show(
          context: context,
          strictbounds: center == null ? false : true,
          apiKey: kGoogleApiKey,
          // onError: onError,
          mode: Mode.fullscreen,
          // hint: "ابحث",
          // language: "ar",
          location: center == null
              ? null
              : Location(center.latitude, center.longitude),
          radius: center == null ? null : 1000000000);
      print("my p is :$p");
      showDetailPlace(p.placeId);
    } catch (e) {
      print("google places error :$e");
      return;
    }
  }

  Future<Null> showDetailPlace(String placeId) async {
    print("placeId :$placeId");
    if (placeId != null) {
      PlacesDetailsResponse place = await _places.getDetailsByPlaceId(placeId);
      var lat = place.result.geometry.location.lat;
      var lng = place.result.geometry.location.lng;
      formattedAddress = place.result.formattedAddress;
      widget.onLocationChange(lat, lng);
      geoToSpecificLocation(lat, lng);
    }
  }

  handleSearchBtn() {
    return InkWell(
      onTap: () => openPlacesScreen(),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 15.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(100.0)),
        child: Row(
          children: <Widget>[
            Icon(
              Icons.search,
              color: Color(0xFFff8500),
            ),
            SizedBox(width: 10,),
            Container(
              width: MediaQuery.of(context).size.width * 0.62,
              child: Text("Search ...",style: TextStyle(fontFamily: 'jana',fontWeight: FontWeight.bold,fontSize: 16,color: Colors.grey),),
            )
          ],
        ),
      ),
    );
  }

  Future<void> geoToSpecificLocation(lat, lng) async {
    CameraPosition locationPosition = CameraPosition(
      target: LatLng(lat, lng),
      tilt: 50.0,
      bearing: 45.0,
      zoom: 15.0,
    );
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(locationPosition));
  }

  Future<void> _gotoMyLocation() async {
    CameraPosition myLocationPosition = await _getUserLocation();
    final GoogleMapController controller = await _controller.future;
    controller
        .animateCamera(CameraUpdate.newCameraPosition(myLocationPosition));
  }
}

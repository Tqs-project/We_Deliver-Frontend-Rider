import 'dart:async';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as gmap;
import 'package:http/http.dart' as http;
import 'package:sprintf/sprintf.dart';
import '../locations.dart' as loc;
import 'dart:convert';
import 'package:polyline/polyline.dart';

class LocationBloc {
  StreamController<GpsData> gpsDataStreamController =
      StreamController<GpsData>.broadcast();
  Stream get getGpsData => gpsDataStreamController.stream;

  Geolocator geolocator = Geolocator();
  loc.LatLng location = loc.LatLng();
  // Object for PolylinePoints
  PolylinePoints polylinePoints = PolylinePoints();

// List of coordinates to join
  List<loc.LatLng> polylineCoordinates = [];

  void initialize() {
    _determinePosition();
  }

  Future<bool> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    var _temp = await Geolocator.getCurrentPosition();
    location = loc.LatLng(lat: _temp.latitude, lng: _temp.longitude);

    Geolocator.getPositionStream().listen((position) {
      location = loc.LatLng(lat: position.latitude, lng: position.longitude);
    });
    return true;
  }

  Future calculateRoute(
      String storeName, String storeAddress, String destinationAddress) async {
    var addresses = await Geocoder.local.findAddressesFromQuery(storeAddress);
    var destinations =
        await Geocoder.local.findAddressesFromQuery(destinationAddress);

    var storeCoords = addresses.first.coordinates;
    var destinationCoords = destinations.first.coordinates;

    var _temp = <String?, gmap.Marker>{};
    var marker = gmap.Marker(
      markerId: gmap.MarkerId(storeName),
      position: gmap.LatLng(storeCoords.latitude, storeCoords.longitude),
      infoWindow: gmap.InfoWindow(
        title: storeName,
        snippet: storeAddress,
      ),
    );
    _temp[storeName] = marker;
    var marker2 = gmap.Marker(
      markerId: gmap.MarkerId(destinationAddress),
      position:
          gmap.LatLng(destinationCoords.latitude, destinationCoords.longitude),
      infoWindow: gmap.InfoWindow(
        title: destinationAddress,
      ),
    );
    _temp[destinationAddress] = marker2;

    var url = sprintf(
        'https://maps.googleapis.com/maps/api/directions/json?origin=%s,%s&destination=%s&waypoints=%s&key=%s',
        [
          location.lat.toString(),
          location.lng.toString(),
          destinationAddress,
          storeAddress,
          'AIzaSyBPi7DD20WaxRNbaic5aVNwV3mbWCnioHk',
        ]);
    debugPrint(url);
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var encoded = json.decode(response.body)['routes'][0]['overview_polyline']
          ['points'];
      debugPrint(encoded.toString());
      var decoded = Polyline.Decode(encodedString: encoded.toString());

      var polyline = gmap.Polyline(
          polylineId: gmap.PolylineId('route'),
          color: Color.fromARGB(255, 40, 122, 198),
          points: toLatLng(decoded.decodedCoords));
      var _polylines = <gmap.Polyline>{};

      _polylines.add(polyline);
      update(_polylines, _temp);
    }
  }

  void update(Set<gmap.Polyline> route, Map<String?, gmap.Marker> _markers) {
    gpsDataStreamController.sink.add(GpsData(
        location, route, _markers)); // add whatever data we want into the Sink
  }

  List<gmap.LatLng> toLatLng(List<List<double>> points) {
    var data = <gmap.LatLng>[];
    for (var i in points) {
      data.add(gmap.LatLng(i.first, i.last));
    }

    return data;
  }
}

final locationBloc = LocationBloc();

class GpsData {
  GpsData(this.location, this.route, this.markers);
  loc.LatLng location;
  Set<gmap.Polyline> route;
  Map<String?, gmap.Marker> markers = {};
}

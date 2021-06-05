import 'dart:async';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as Gmap;
import 'package:http/http.dart' as http;
import 'package:sprintf/sprintf.dart';
import '../locations.dart' as Loc;
import 'dart:convert';
import 'package:polyline/polyline.dart';

class LocationBloc {
  StreamController<GpsData> gpsDataStreamController =
      StreamController<GpsData>.broadcast();
  Stream get getGpsData => gpsDataStreamController.stream;

  Geolocator geolocator = Geolocator();
  Loc.LatLng location = Loc.LatLng();
  // Object for PolylinePoints
  PolylinePoints polylinePoints = PolylinePoints();

// List of coordinates to join
  List<Loc.LatLng> polylineCoordinates = [];

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
    location = Loc.LatLng(lat: _temp.latitude, lng: _temp.longitude);

    Geolocator.getPositionStream().listen((position) {
      location = Loc.LatLng(lat: position.latitude, lng: position.longitude);
    });
    return true;
  }

  Future calculateRoute(String storeQ, String destinationQ) async {
    var addresses = await Geocoder.local.findAddressesFromQuery(storeQ);
    var destinations =
        await Geocoder.local.findAddressesFromQuery(destinationQ);

    var storeCoords = addresses.first.coordinates;
    var store =
        Loc.LatLng(lat: storeCoords.latitude, lng: storeCoords.longitude);

    var destinationCoords = destinations.first.coordinates;
    var destination = Loc.LatLng(
        lat: destinationCoords.latitude, lng: destinationCoords.longitude);

    String url = sprintf(
        "https://maps.googleapis.com/maps/api/directions/json?origin=%s,%s&destination=%s&waypoints=%s&key=%s",
        [
          location.lat.toString(),
          location.lng.toString(),
          destinationQ,
          storeQ,
          "AIzaSyBPi7DD20WaxRNbaic5aVNwV3mbWCnioHk",
        ]);
    debugPrint(url);
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var encoded = json.decode(response.body)["routes"][0]["overview_polyline"]
          ["points"];
      debugPrint(encoded.toString());
      var decoded = Polyline.Decode(encodedString: encoded.toString());

      Gmap.Polyline polyline = Gmap.Polyline(
          polylineId: Gmap.PolylineId('route'),
          color: Color.fromARGB(255, 40, 122, 198),
          points: toLatLng(decoded.decodedCoords));
      Set<Gmap.Polyline> _polylines = {};

      _polylines.add(polyline);
      update(_polylines);
    }
  }

  void update(Set<Gmap.Polyline> route) {
    gpsDataStreamController.sink.add(
        GpsData(location, route)); // add whatever data we want into the Sink
  }

  List<Gmap.LatLng> toLatLng(List<List<double>> points) {
    List<Gmap.LatLng> data = <Gmap.LatLng>[];
    for (var i in points) {
      data.add(Gmap.LatLng(i.first, i.last));
    }

    return data;
  }
}

final locationBloc = LocationBloc();

class GpsData {
  Loc.LatLng location;
  Set<Gmap.Polyline> route;

  GpsData(this.location, this.route);
}

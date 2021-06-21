import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as gmap;

import 'package:http/http.dart';
import 'package:sprintf/sprintf.dart';
import '../locations.dart' as loc;
import 'dart:convert';
import 'package:polyline/polyline.dart';

class LocationBloc {
  StreamController<GpsData> gpsDataStreamController =
      StreamController<GpsData>.broadcast();
  Stream get getGpsData => gpsDataStreamController.stream;

  final String BASE_URL = 'webmarket-314811.oa.r.appspot.com';
  Geolocator geolocator = Geolocator();
  loc.LatLng location = loc.LatLng();
  // Object for PolylinePoints
  PolylinePoints polylinePoints = PolylinePoints();

// List of coordinates to join
  List<loc.LatLng> polylineCoordinates = [];

  void initialize(String username, String token, Client client) {
    _determinePosition(username, token, client);
  }

  Future<Address> getAddressFromCoordinates() async {
    final coordinates = Coordinates(location.lat, location.lng);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    return addresses.first;
  }

  Future<bool> _determinePosition(
      String username, String token, Client client) async {
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
      postLocation(token, username, location, client);
    });
    return true;
  }

  Future<Response> postLocation(String token, String username,
      loc.LatLng clocation, Client client) async {
    var uri = Uri.https(BASE_URL, ('/api/riders/location'));
    final response = await client.post(uri,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          'Access-Control-Allow-Origin': '*',
          'idToken': token,
          'username': username
        },
        body: jsonEncode({
          'lat': clocation.lat.toString(),
          'lng': clocation.lng.toString(),
        }));
    return response;
  }

  Future<double> getDistance(
      String storeAddress, String destinationAddress, Client client) async {
    var url = sprintf(
        'https://maps.googleapis.com/maps/api/directions/json?origin=%s,%s&destination=%s&waypoints=%s&key=%s',
        [
          location.lat.toString(),
          location.lng.toString(),
          destinationAddress,
          storeAddress,
          'AIzaSyBPi7DD20WaxRNbaic5aVNwV3mbWCnioHk',
        ]);
    var response = await client.get(Uri.parse(url));
    if (response.statusCode == 200) {
      if ((json.decode(response.body)['routes']) == []) return 0;

      try {
        var distance = int.parse(json
                .decode(response.body)['routes'][0]['legs'][0]['distance']
                    ['value']
                .toString()) /
            1000;
        return distance;
      } on Exception catch (_) {
        return 0;
      } catch (error) {
        return 0;
      }
    }
    return 0;
  }

  Future<List<Address>> getGeocoderAddressesByQuery(
      String storeAddress, String destinationAddress) async {
    var addresses = await Geocoder.local.findAddressesFromQuery(storeAddress);
    var destinations =
        await Geocoder.local.findAddressesFromQuery(destinationAddress);

    return [addresses.first, destinations.first];
  }

  Future<Response> calculateRoute(
      String storeAddress, String destinationAddress, Client client) async {
    try {
      var returned =
          await getGeocoderAddressesByQuery(storeAddress, destinationAddress);

      var addresses = returned[0];
      var destinations = returned[1];

      var storeCoords = addresses.coordinates;
      var destinationCoords = destinations.coordinates;

      var _temp = <String?, gmap.Marker>{};
      var marker = gmap.Marker(
        markerId: gmap.MarkerId(storeAddress),
        position: gmap.LatLng(storeCoords.latitude, storeCoords.longitude),
        infoWindow: gmap.InfoWindow(
          title: storeAddress,
          snippet: storeAddress,
        ),
      );
      _temp[storeAddress] = marker;
      var marker2 = gmap.Marker(
        markerId: gmap.MarkerId(destinationAddress),
        position: gmap.LatLng(
            destinationCoords.latitude, destinationCoords.longitude),
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
      var response = await client.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var encoded = json.decode(response.body)['routes'][0]
            ['overview_polyline']['points'];

        var decoded = Polyline.Decode(encodedString: encoded.toString());

        var polyline = gmap.Polyline(
            polylineId: gmap.PolylineId('route'),
            color: Color.fromARGB(255, 40, 122, 198),
            points: toLatLng(decoded.decodedCoords));
        var _polylines = <gmap.Polyline>{};

        _polylines.add(polyline);
        update(_polylines, _temp);
      }
      return response;
    } catch (_) {
      return Response('Address Not Found', 204);
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

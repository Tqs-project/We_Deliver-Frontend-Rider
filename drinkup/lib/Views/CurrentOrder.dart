import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wedeliver/Blocs/LocationBloc.dart';

import 'Profile.dart';

class CurrentOrder extends StatefulWidget {
  CurrentOrder(this.title);
  String title = "";
  @override
  _CurrentOrderState createState() => _CurrentOrderState();
}

class _CurrentOrderState extends State<CurrentOrder> {
  final Color foregroundColor = Colors.white;

  var title = "";
  @override
  void initState() {
    super.initState();
    title = widget.title;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            title,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.person,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Profile(title)),
                );
              },
            ),
            IconButton(
              icon: Icon(
                Icons.settings,
                color: Colors.white,
              ),
              onPressed: () {
                // do something
              },
            ),
          ],
          elevation: 0,
          brightness: Brightness.light,
          backgroundColor: Color.fromRGBO(40, 40, 61, 0.8),
        ),
        body: GPSorderPage(context));
  }

  Widget GPSorderPage(BuildContext context) {
    return Center(
        child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: Color.fromRGBO(31, 29, 47, 1),
            ),
            child: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                        width: MediaQuery.of(context).size.width /
                            1.05, // or use fixed size like 200
                        height: MediaQuery.of(context).size.height / 2.2,
                        child: GpsSection(context)),
                    OrderDetails(context)
                  ]),
            )));
  }

  var initialCameraPosition;
  Widget GpsSection(BuildContext context) {
    locationBloc.calculateRoute("Casa Pina",
        "R. Antónia Rodrigues 36, 3800-102 Aveiro", "DETI 3810-193 Aveiro");
    return StreamBuilder(
        stream: locationBloc.getGpsData,
        builder: (context, snapshot) {
          if (!snapshot.hasData) return CircularProgressIndicator();
          var details = snapshot.data as GpsData;
          initialCameraPosition = CameraPosition(
            target: LatLng(details.location.lat!.toDouble(),
                details.location.lng!.toDouble()),
            zoom: 14,
          );

          return Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
              alignment: Alignment.topCenter,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              padding: const EdgeInsets.only(left: 5.0, right: 5.0),
              child: GoogleMap(
                  myLocationEnabled: true,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(details.location.lat!.toDouble(),
                        details.location.lng!.toDouble()),
                    zoom: 12,
                  ),
                  markers: details.markers.values.toSet(),
                  polylines: details.route));
        });
  }

  Widget OrderDetails(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      margin: EdgeInsets.all(20),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color.fromRGBO(40, 40, 61, 1),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Divider(
            height: 20,
            thickness: 0,
          ),
          Center(
            child: Text(
              'Order Details',
              textScaleFactor: 1.0,
              style: TextStyle(
                  fontSize: 22.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          Text(
            '#916544',
            style: TextStyle(
                color: Colors.white,
                decorationColor: Colors.white,
                fontSize: 16),
          ),
          Divider(
            height: 20,
            thickness: 2,
            color: Colors.red[400],
          ),
          Container(
            height: MediaQuery.of(context).size.height / 6,
            child: ListView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              padding: const EdgeInsets.all(6),
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(40, 40, 61, 1),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text(
                      "From Casa Pina, R. Antónia Rodrigues 36, 3800-102 Aveiro",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          decorationColor: Colors.white,
                          fontSize: 16)),
                ),
                Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.all(4.0),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(40, 40, 61, 1),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text(
                      'To DETI 3810-193 Aveiro',
                      style: TextStyle(
                          color: Colors.white,
                          decorationColor: Colors.white,
                          fontSize: 16),
                    )),
                Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.all(4.0),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(40, 40, 61, 1),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text(
                      'Arthur Shelby, 913 512 615',
                      style: TextStyle(
                          color: Colors.white,
                          decorationColor: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    )),
              ],
            ),
          ),
          Divider(
            height: 20,
            thickness: 2,
            color: Colors.red[400],
          ),
          Center(
            child: Text(
              'Profit: 3.06€',
              textScaleFactor: 1.0, // disables accessibility
              style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Divider(
            height: 20,
            thickness: 2,
            color: Color.fromRGBO(40, 40, 61, 1),
          ),
        ],
      ),
    );
  }
}

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';
import 'package:wedeliver/Blocs/AuthenticationBloc.dart';
import 'package:wedeliver/Blocs/LocationBloc.dart';
import 'package:wedeliver/Blocs/OrdersBloc.dart';
import 'package:wedeliver/Entities/Order.dart';
import 'package:wedeliver/Views/Orders.dart';

import 'Profile.dart';

// ignore: must_be_immutable
class CurrentOrder extends StatefulWidget {
  CurrentOrder(this.title, this.userData, this.currentOrder);
  UserData userData;
  String title;
  Order currentOrder;
  @override
  _CurrentOrderState createState() => _CurrentOrderState();
}

class _CurrentOrderState extends State<CurrentOrder> {
  final Color foregroundColor = Colors.white;
  late UserData userData;
  late Order order;
  var title = '';
  @override
  void initState() {
    super.initState();
    userData = widget.userData;
    order = widget.currentOrder;

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
                        height: MediaQuery.of(context).size.height / 2.4,
                        child: GpsSection(context)),
                    OrderDetails(context)
                  ]),
            )));
  }

  var initialCameraPosition;
  Widget GpsSection(BuildContext context) {
    locationBloc.calculateRoute(order.storeLocation, order.customerLocation);
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
                  key: Key('GoogleMap'),
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
            '#' + order.id.toString(),
            style: TextStyle(
                color: Colors.white,
                decorationColor: Colors.white,
                fontSize: 16),
          ),
          // ignore: deprecated_member_use
          RaisedButton(
            onPressed: () {
              ordersBloc.delivered(order.id, userData.loginData.token,
                  userData.riderData.username, Client());
              ordersBloc.getRiderOrders(
                  userData.riderData, userData.loginData.token, Client());

              Fluttertoast.showToast(
                  msg: 'Order has been delivered',
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.green,
                  textColor: Colors.black,
                  fontSize: 16.0);
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) => Orders(title, userData)),
                  (Route<dynamic> route) => false);
            },
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(80.0)),
            padding: const EdgeInsets.all(0.0),
            child: Ink(
              decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [Colors.red, Colors.white]),
                borderRadius: BorderRadius.all(Radius.circular(80.0)),
              ),
              child: Container(
                constraints: const BoxConstraints(
                    minWidth: 88.0,
                    minHeight: 36.0), // min sizes for Material buttons
                alignment: Alignment.center,
                child: const Text(
                  'Delivered',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
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
                  child: Text('From ' + order.storeLocation,
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
                      'To ' + order.customerLocation,
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
                      order.username,
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
              'Profit: ' + order.cost.toString() + '€',
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

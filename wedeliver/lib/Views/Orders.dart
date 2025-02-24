import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:wedeliver/Blocs/AuthenticationBloc.dart';
import 'package:wedeliver/Blocs/LocationBloc.dart';
import 'package:wedeliver/Blocs/OrdersBloc.dart';
import 'package:wedeliver/Entities/Order.dart';
import 'package:wedeliver/Views/Authentication.dart';
import 'CurrentOrder.dart';
import 'Profile.dart';

// ignore: must_be_immutable
class Orders extends StatefulWidget {
  Orders(this.title, this.userData);
  String title;
  UserData userData;
  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  final Color foregroundColor = Colors.white;
  Order currentOrder = Order.empty();

  late UserData userData;
  double distance = 0;
  var title = '';
  @override
  void initState() {
    super.initState();
    title = widget.title;
    userData = widget.userData;
    var httpClient = Client();
    locationBloc.initialize(
        userData.riderData.username, userData.loginData.token, Client());
    ordersBloc.getRiderOrders(
        userData.riderData, userData.loginData.token, httpClient, locationBloc);
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
                  MaterialPageRoute(
                      builder: (context) => Profile(title, userData)),
                );
              },
            ),
            IconButton(
              icon: Icon(
                Icons.logout,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) => Authentication(title)),
                    (Route<dynamic> route) => false);
              },
            ),
          ],
          elevation: 0,
          brightness: Brightness.light,
          backgroundColor: Color.fromRGBO(40, 40, 61, 0.8),
          automaticallyImplyLeading: false,
        ),
        body: PageWithOrders(context));
  }

  Widget PageWithOrders(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromRGBO(31, 29, 47, 1),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[OrderList(), CurrentSelectedOrder()],
      ),
    );
  }

  Widget OrderList() {
    return StreamBuilder(
        stream: ordersBloc.getOrderStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: CircularProgressIndicator());
          }
          var current = (snapshot.data) as Order;

          return Expanded(
              child: Container(
            height: MediaQuery.of(context).size.height / 2.3,
            alignment: Alignment.topCenter,
            margin: EdgeInsets.all(20),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Color.fromRGBO(40, 40, 61, 0.8),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                    child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Orders',
                    textScaleFactor: 1.0, // disables accessibility
                    style: TextStyle(
                      fontSize: 30.0,
                      color: Colors.white,
                    ),
                  ),
                )),
                Divider(height: 10, thickness: 2, color: Colors.red[400]),
                Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    children: <Widget>[
                      current.id == -99
                          ? GestureDetector(
                              onTap: () {
                                setState(() {
                                  ordersBloc.getRiderOrders(
                                      userData.riderData,
                                      userData.loginData.token,
                                      Client(),
                                      locationBloc);
                                });
                                Fluttertoast.showToast(
                                    msg: 'Reloading...',
                                    toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.grey,
                                    textColor: Colors.black,
                                    fontSize: 16.0);
                              },
                              child: Container(
                                margin: EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ClipRRect(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
                                      child:
                                          Image.asset('assets/purchase-red.jpg',
                                              // width: 300,
                                              height: 40,
                                              fit: BoxFit.fill),
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          'No Order Is Avaliable For Now',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          'Click To Reload',
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ))
                          : GestureDetector(
                              onTap: () {
                                setState(() {
                                  currentOrder = current;
                                  setDistance();
                                  currentOrder = current;
                                });
                              },
                              child: Container(
                                margin: EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ClipRRect(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
                                      child:
                                          Image.asset('assets/purchase-red.jpg',
                                              // width: 300,
                                              height: 40,
                                              fit: BoxFit.fill),
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          current.username,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          'Profit: ' +
                                              current.cost.toString() +
                                              '€',
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              )),
                    ],
                  ),
                )
              ],
            ),
          ));
        });
  }

  Widget CurrentSelectedOrder() {
    Divider();
    return currentOrder.id == -99
        ? Text('No Order Has Been Selected',
            style: TextStyle(color: Colors.white))
        : Container(
            alignment: Alignment.topCenter,
            margin: EdgeInsets.all(20),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Color.fromRGBO(40, 40, 61, 0.8),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text(
                      'Current Order',
                      textScaleFactor: 1.0, // disables accessibility
                      style: TextStyle(
                        fontSize: 25.0,
                        color: Colors.white,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // ignore: deprecated_member_use
                        RaisedButton(
                          onPressed: () {
                            // ignore: unnecessary_null_comparison
                            if (currentOrder != null) {
                              ordersBloc.acceptOrder(userData.riderData,
                                  userData.loginData.token, Client());
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CurrentOrder(
                                        title, userData, currentOrder)),
                              );
                            }
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(80.0)),
                          padding: const EdgeInsets.all(0.0),
                          child: Ink(
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [Colors.green, Colors.white]),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(80.0)),
                            ),
                            child: Container(
                              constraints: const BoxConstraints(
                                  minWidth: 88.0,
                                  minHeight:
                                      36.0), // min sizes for Material buttons
                              alignment: Alignment.center,
                              child: const Text(
                                'Accept',
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                        // ignore: deprecated_member_use
                        RaisedButton(
                          onPressed: () {
                            ordersBloc.declineOrder(
                                userData.riderData,
                                userData.loginData.token,
                                Client(),
                                locationBloc);
                            setState(() {
                              currentOrder = Order.empty();
                            });
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(80.0)),
                          padding: const EdgeInsets.all(0.0),
                          child: Ink(
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [Colors.red, Colors.white]),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(80.0)),
                            ),
                            child: Container(
                              constraints: const BoxConstraints(
                                  minWidth: 88.0,
                                  minHeight:
                                      36.0), // min sizes for Material buttons
                              alignment: Alignment.center,
                              child: const Text(
                                'Decline',
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                Divider(height: 10, thickness: 2, color: Colors.red[400]),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Column(
                    children: [
                      Text('User Details',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16)),
                      Divider(height: 5, thickness: 5, color: Colors.red[300]),
                      ListView(
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(8),
                        children: <Widget>[
                          Container(
                              child: Column(
                            children: [
                              Text(currentOrder.username,
                                  style: TextStyle(
                                    color: Colors.white,
                                  )),
                              Text(distance.toString() + 'Km Away',
                                  style: TextStyle(
                                    color: Colors.white,
                                  )),
                            ],
                          )),
                          Container(
                            child: Text(
                                'Delivery: ' + currentOrder.customerLocation,
                                style: TextStyle(
                                  color: Colors.white,
                                )),
                          ),
                          Container(
                            child: Text('Store: ' + currentOrder.storeLocation,
                                style: TextStyle(
                                  color: Colors.white,
                                )),
                          ),
                          Divider(
                              height: 5, thickness: 5, color: Colors.red[300]),
                          Text(
                            'Profit: ' + currentOrder.cost.toString() + '€',
                            textAlign: TextAlign.end,
                            style: TextStyle(
                                color: Colors.white,
                                decorationColor: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ));
  }

  Future setDistance() async {
    var _distance = await locationBloc.getDistance(
        currentOrder.storeLocation, currentOrder.customerLocation, Client());
    setState(() {
      distance = _distance;
    });
  }
}

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';

class Orders extends StatefulWidget {
  Orders({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  final Color foregroundColor = Colors.white;
  String typeOfTransport = "CAR";
  var pressed = 'LOGIN';
  var typeOfUser = 'RIDER';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Drink Up"),
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
        children: <Widget>[OrderList(), CurrentOrder()],
      ),
    );
  }

  Widget OrderList() {
    return Container(
      height: MediaQuery.of(context).size.height / 4,
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
                GestureDetector(
                    child: Container(
                  margin: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.all(new Radius.circular(8)),
                        child: Image.asset('assets/purchase-red.jpg',
                            // width: 300,
                            height: 40,
                            fit: BoxFit.fill),
                      ),
                      Column(
                        children: [
                          Text(
                            'Arthur Shelby',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'By order of the peaky blinders',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )),
                GestureDetector(
                    child: Container(
                  margin: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.all(new Radius.circular(8)),
                        child: Image.asset('assets/purchase-red.jpg',
                            // width: 300,
                            height: 40,
                            fit: BoxFit.fill),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Arthur Shelby',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'By order of the peaky blinders',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      )
                    ],
                  ),
                )),
                GestureDetector(
                    child: Container(
                  margin: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.all(new Radius.circular(8)),
                        child: Image.asset('assets/purchase-red.jpg',
                            // width: 300,
                            height: 40,
                            fit: BoxFit.fill),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Arthur Shelby',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'By order of the peaky blinders',
                            style: TextStyle(color: Colors.white),
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
    );
  }

  Widget CurrentOrder() {
    return Container(
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Current Order',
                  textScaleFactor: 1.0, // disables accessibility
                  style: TextStyle(
                    fontSize: 25.0,
                    color: Colors.white,
                  ),
                ),
                RaisedButton(
                  onPressed: () {},
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80.0)),
                  padding: const EdgeInsets.all(0.0),
                  child: Ink(
                    decoration: const BoxDecoration(
                      gradient:
                          LinearGradient(colors: [Colors.red, Colors.white]),
                      borderRadius: BorderRadius.all(Radius.circular(80.0)),
                    ),
                    child: Container(
                      constraints: const BoxConstraints(
                          minWidth: 88.0,
                          minHeight: 36.0), // min sizes for Material buttons
                      alignment: Alignment.center,
                      child: const Text(
                        'Accept',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                )
              ],
            ),
            Divider(height: 10, thickness: 2, color: Colors.red[400]),
            Container(
              alignment: Alignment.topCenter,
              margin: EdgeInsets.all(10),
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 6,
              decoration: BoxDecoration(
                color: Color.fromRGBO(54, 54, 82, 1),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                children: [
                  Text("Products",
                      style: new TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.white)),
                  Divider(height: 5, thickness: 1, color: Colors.red[400]),
                  Container(
                    child: Expanded(
                      child: ListView(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(12),
                        children: <Widget>[
                          Container(
                            child: Text("1L Vinho do Porto",
                                style: new TextStyle(
                                    fontSize: 14, color: Colors.white)),
                          ),
                          Container(
                              child: Text("1.5L Vodka",
                                  style: new TextStyle(
                                      fontSize: 14, color: Colors.white))),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Column(
                children: [
                  Text("User Details",
                      style: new TextStyle(
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
                          Text('Arthur Shelby',
                              style: new TextStyle(
                                color: Colors.white,
                              )),
                          Text('4Km Away',
                              style: new TextStyle(
                                color: Colors.white,
                              )),
                        ],
                      )),
                      Container(
                        child: Text('Address: ---------',
                            style: new TextStyle(
                              color: Colors.white,
                            )),
                      ),
                      Container(
                        child: Text('Phone Number: 913 514 255',
                            style: new TextStyle(
                              color: Colors.white,
                            )),
                      ),
                      Divider(height: 5, thickness: 5, color: Colors.red[300]),
                      Text("Total: 31,4€",
                          textAlign: TextAlign.right,
                          style: new TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold))
                    ],
                  ),
                ],
              ),
            )
          ],
        ));
  }
}

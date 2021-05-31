
import 'locations.dart' as locations;

import 'package:fl_chart/fl_chart.dart';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:toggle_switch/toggle_switch.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Drink Up',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: Main(title: 'Drink Up'),
    );
  }
}

class Main extends StatefulWidget {


  Main({Key key, this.title}) : super(key: key);

  final String title;


  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  final casaPina = LatLng(40.643540, -8.655130);
  final universidade = LatLng(40.630690, -8.655130);
  final Map<String?, Marker> _markers = {};
  Future<void> _onMapCreated(GoogleMapController controller) async {
    setState(() {
      _markers.clear();

      var marker = Marker(
        markerId: MarkerId("Casa Pina"),
        position: LatLng(casaPina.latitude, casaPina.longitude),
        infoWindow: InfoWindow(
          title: "Casa Pina",
          snippet: "R. Antónia Rodrigues 36, 3800-102 Aveiro",
        ),
      );
      _markers["Casa Pina"] = marker;
      var marker2 = Marker(
        markerId: MarkerId("DETI"),
        position: LatLng(universidade.latitude, universidade.longitude),
        infoWindow: InfoWindow(
          title: "DETI",
          snippet: "3810-193 Aveiro",
        ),
      );
      _markers["DETI"] = marker2;
    });
  }

  final Color foregroundColor = Colors.grey[200];
  int groupValue = 0;

  String typeOfTransport = "CAR";
  int groupValue = 0;
  
  @override 
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Drink Up"),
        ),
        body: Authentication(context) );
  }
  Widget GPSorderPage(BuildContext context){
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
                            child: gpsPage(context)),
                        OrderDetails(context)
                      ]),
                )));
    }
  
  Widget gpsPage(BuildContext context) {
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
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: casaPina,
          zoom: 14,
        ),
        markers: _markers.values.toSet(),


  }
  
  Widget PageWithOrders(BuildContext context){
    return  Container(
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
       
  Widget RiderHome(BuildContext context){
    return Container(
            height: (MediaQuery.of(context).size.height),
            decoration: BoxDecoration(
              color: Color.fromRGBO(31, 29, 47, 1),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[Profile(context), Statistics(context)],
            ))
  }
  Widget Authentication(BuildContext context){
     return SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            pressed == 'LOGIN' ? LoginPage() : RegisterPage(),
          ],
        ),
      );
    }

  Widget Profile(BuildContext context) {
    return Center(
        child: Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.all(10),
      height: (MediaQuery.of(context).size.height) / 1.7,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(new Radius.circular(8)),
        color: Color.fromRGBO(40, 40, 61, 0.8),
      ),
      child: ListView(
        children: [
          Hero(
              tag: "Profile Picture",
              child: Container(
                child: Icon(
                  Icons.person,
                  size: 96,
                  color: Colors.white,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.red,
                    width: 1.0,
                  ),
                  shape: BoxShape.circle,
                  //image: DecorationImage(image: this.logo)
                ),
              )),
          Hero(
            tag: "Harry Potter",
            child: Material(
              type: MaterialType.transparency,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Center(
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    initialValue: "Harry Potter",
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                ),
              ),
            ),
          ),
          TextFormField(
            decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.only(top: 20), // add padding to adjust text
              prefixIcon: Padding(
                padding: EdgeInsets.only(top: 15), // add padding to adjust icon
                child: Icon(Icons.location_city, color: Colors.red),
              ),
            ),
            initialValue: "Privet Drive",
            style: TextStyle(color: Colors.white),
          ),
          TextFormField(
            decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.only(top: 20), // add padding to adjust text
              prefixIcon: Padding(
                padding: EdgeInsets.only(top: 15), // add padding to adjust icon
                child: Icon(Icons.email, color: Colors.red),
              ),
            ),
            initialValue: "hp@hogwarts.com",
            style: TextStyle(color: Colors.white),
          ),
          TextFormField(
            decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.only(top: 20), // add padding to adjust text
              prefixIcon: Padding(
                padding: EdgeInsets.only(top: 15), // add padding to adjust icon
                child: Icon(Icons.phone, color: Colors.red),
              ),
            ),
            initialValue: "913 415 285",
            style: TextStyle(color: Colors.white),
          ),
          Divider(
            height: 10,
          ),
          Center(
            child: ToggleSwitch(
              initialLabelIndex: 1,
              minWidth: 90,
              cornerRadius: 20.0,
              activeFgColor: Colors.white,
              inactiveBgColor: Colors.grey,
              inactiveFgColor: Colors.white,
              labels: ['', '', ''],
              icons: [
                Icons.directions_car,
                Icons.directions_bike,
                Icons.directions_walk
              ],
              activeBgColors: [
                Colors.red[400],
                Colors.red[400],
                Colors.red[400]
              ],
              onToggle: (index) {
                if (index == 0)
                  typeOfTransport = 'RIDER';
                else
                  typeOfTransport = 'CLIENT';
              },
            ),
          ),
          Center(
              child: RaisedButton(
            onPressed: () {},
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(80.0)),
            padding: const EdgeInsets.all(0.0),
            child: Ink(
              decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [Colors.red, Colors.white]),
                borderRadius: BorderRadius.all(Radius.circular(80.0)),
              ),
              child: Container(
                width: (MediaQuery.of(context).size.width) / 3,
                constraints: const BoxConstraints(
                    minWidth: 8.0,
                    minHeight: 36.0), // min sizes for Material buttons
                alignment: Alignment.center,
                child: const Text(
                  'Save',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          )),
        ],
      ),
    ));
  }

  Widget Statistics(BuildContext context) {
    return Expanded(
        child: Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.all(10),
      height: (MediaQuery.of(context).size.height) / 2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(new Radius.circular(8)),
        color: Color.fromRGBO(40, 40, 61, 0.8),
      ),
      child: ListView(
        children: [
          Hero(
            tag: "Statistics",
            child: Material(
              type: MaterialType.transparency,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Center(
                  child: Text(
                    "Statistics (Today)",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
          Divider(
            height: 10,
            color: Colors.red[400],
            thickness: 2,
          ),
          Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Number Of Orders Accepted",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                  Text("12", style: TextStyle(color: Colors.white))
                ],
              )),
          Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Total Profit",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                  Text("43€", style: TextStyle(color: Colors.white))
                ],
              )),
          Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Travelled Distance",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                  Text("19.3Km", style: TextStyle(color: Colors.white))
                ],
              )),
          Divider(
            height: 10,
          ),
        ],
      ),
    ));
  final Color foregroundColor = Colors.white;
  var pressed = 'LOGIN';
  var typeOfUser = 'RIDER';

  

  Widget LoginPage() {
    return Container(
      decoration: new BoxDecoration(
        gradient: new LinearGradient(
          begin: Alignment.centerLeft,
          end: new Alignment(
              1.0, 0.0), // 10% of the width, so there are ten blinds.
          colors: [
            Color.fromRGBO(31, 29, 47, 1),
            Color.fromRGBO(31, 29, 47, 0.9),
          ], // whitish to gray
          tileMode: TileMode.clamp, // repeats the gradient over the canvas
        ),
      ),
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(top: 150.0, bottom: 50.0),
            child: Center(
              child: new Column(
                children: <Widget>[
                  Container(
                    child: Text(
                      "Drink Up",
                      style: TextStyle(
                          fontSize: 50.0,
                          fontWeight: FontWeight.w100,
                          color: Colors.white),
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: this.foregroundColor,
                        width: 1.0,
                      ),
                      shape: BoxShape.circle,
                      //image: DecorationImage(image: this.logo)
                    ),
                  ),
                ],
              ),
            ),
          ),
          new Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 40.0, right: 40.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                    color: this.foregroundColor,
                    width: 0.5,
                    style: BorderStyle.solid),
              ),
            ),
            padding: const EdgeInsets.only(left: 0.0, right: 10.0),
            child: new Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Padding(
                  padding:
                      EdgeInsets.only(top: 10.0, bottom: 10.0, right: 00.0),
                  child: Icon(
                    Icons.alternate_email,
                    color: this.foregroundColor,
                  ),
                ),
                new Expanded(
                  child: TextField(
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Email',
                      hintStyle: TextStyle(color: this.foregroundColor),
                    ),
                  ),
                ),
              ],
            ),
          ),
          new Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                    color: this.foregroundColor,
                    width: 0.5,
                    style: BorderStyle.solid),
              ),
            ),
            padding: const EdgeInsets.only(left: 0.0, right: 10.0),
            child: new Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Padding(
                  padding:
                      EdgeInsets.only(top: 10.0, bottom: 10.0, right: 00.0),
                  child: Icon(
                    Icons.lock_open,
                    color: this.foregroundColor,
                  ),
                ),
                new Expanded(
                  child: TextField(
                    obscureText: true,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Password',
                      hintStyle: TextStyle(color: this.foregroundColor),
                    ),
                  ),
                ),
              ],
            ),
          ),
          new Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 30.0),
            alignment: Alignment.center,
            child: new Row(
              children: <Widget>[
                new Expanded(
                  child: new FlatButton(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20.0, horizontal: 20.0),
                    color: Colors.red[400],
                    onPressed: () => {},
                    child: Text(
                      "Log In",
                      style: TextStyle(color: this.foregroundColor),
                    ),
                  ),
                ),
              ],
            ),
          ),
          new Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
            alignment: Alignment.center,
            child: new Row(
              children: <Widget>[
                new Expanded(
                  child: new FlatButton(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20.0, horizontal: 20.0),
                    color: Colors.transparent,
                    onPressed: () => {},
                    child: Text(
                      "Forgot your password?",
                      style: TextStyle(
                          color: this.foregroundColor.withOpacity(0.5)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          new Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(
                left: 40.0, right: 40.0, top: 10.0, bottom: 20.0),
            alignment: Alignment.center,
            child: new Row(
              children: <Widget>[
                new Expanded(
                  child: new FlatButton(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20.0, horizontal: 20.0),
                    color: Colors.transparent,
                    onPressed: () => {
                      setState(() {
                        pressed = "REGISTER";
                      })
                    },
                    child: Text(
                      "Don't have an account? Create One",
                      style: TextStyle(
                          color: this.foregroundColor.withOpacity(0.5)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget RegisterPage() {
    return Container(
      decoration: new BoxDecoration(
        gradient: new LinearGradient(
          begin: Alignment.centerLeft,
          end: new Alignment(
              1.0, 0.0), // 10% of the width, so there are ten blinds.
          colors: [
            Color.fromRGBO(31, 29, 47, 1),
            Color.fromRGBO(31, 29, 47, 0.9),
          ], // whitish to gray
          tileMode: TileMode.repeated, // repeats the gradient over the canvas
        ),
      ),
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(top: 150.0, bottom: 50.0),
            child: Center(
              child: new Column(
                children: <Widget>[
                  Container(
                    child: new Text(
                      "Drink Up",
                      style: TextStyle(
                          fontSize: 50.0,
                          fontWeight: FontWeight.w100,
                          color: Colors.white),
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: this.foregroundColor,
                        width: 1.0,
                      ),
                      shape: BoxShape.circle,
                      //image: DecorationImage(image: this.logo)
                    ),
                  ),
                ],
              ),
            ),
          ),
          new Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 40.0, right: 40.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                    color: this.foregroundColor,
                    width: 0.5,
                    style: BorderStyle.solid),
              ),
            ),
            padding: const EdgeInsets.only(left: 0.0, right: 10.0),
            child: new Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Padding(
                  padding:
                      EdgeInsets.only(top: 10.0, bottom: 10.0, right: 00.0),
                  child: Icon(
                    Icons.alternate_email,
                    color: this.foregroundColor,
                  ),
                ),
                new Expanded(
                  child: TextField(
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Email',
                      hintStyle: TextStyle(color: this.foregroundColor),
                    ),
                  ),
                ),
              ],
            ),
          ),
          new Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 40.0, right: 40.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                    color: this.foregroundColor,
                    width: 0.5,
                    style: BorderStyle.solid),
              ),
            ),
            padding: const EdgeInsets.only(left: 0.0, right: 10.0),
            child: new Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Padding(
                  padding:
                      EdgeInsets.only(top: 10.0, bottom: 10.0, right: 00.0),
                  child: Icon(
                    Icons.person,
                    color: this.foregroundColor,
                  ),
                ),
                new Expanded(
                  child: TextField(
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Name',
                      hintStyle: TextStyle(color: this.foregroundColor),
                    ),
                  ),
                ),
              ],
            ),
          ),
          new Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                    color: this.foregroundColor,
                    width: 0.5,
                    style: BorderStyle.solid),
              ),
            ),
            padding: const EdgeInsets.only(left: 0.0, right: 10.0),
            child: new Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Padding(
                  padding:
                      EdgeInsets.only(top: 10.0, bottom: 10.0, right: 00.0),
                  child: Icon(
                    Icons.lock_open,
                    color: this.foregroundColor,
                  ),
                ),
                new Expanded(
                  child: TextField(
                    obscureText: true,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Password',
                      hintStyle: TextStyle(color: this.foregroundColor),
                    ),
                  ),
                ),
              ],
            ),
          ),
          new Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                    color: this.foregroundColor,
                    width: 0.5,
                    style: BorderStyle.solid),
              ),
            ),
            padding: const EdgeInsets.only(left: 0.0, right: 10.0),
            child: new Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Padding(
                  padding:
                      EdgeInsets.only(top: 10.0, bottom: 10.0, right: 00.0),
                  child: Icon(
                    Icons.lock_open,
                    color: this.foregroundColor,
                  ),
                ),
                new Expanded(
                  child: TextField(
                    obscureText: true,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Confirm Password',
                      hintStyle: TextStyle(color: this.foregroundColor),
                    ),
                  ),
                ),
              ],
            ),
          ),
          new Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                    color: this.foregroundColor,
                    width: 0.5,
                    style: BorderStyle.solid),
              ),
            ),
            padding: const EdgeInsets.only(left: 0.0, right: 10.0),
            child: new Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Padding(
                  padding:
                      EdgeInsets.only(top: 10.0, bottom: 10.0, right: 00.0),
                  child: Icon(
                    Icons.location_city,
                    color: this.foregroundColor,
                  ),
                ),
                new Expanded(
                  child: TextField(
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'City',
                      hintStyle: TextStyle(color: this.foregroundColor),
                    ),
                  ),
                ),
              ],
            ),
          ),
          new Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 30.0),
            alignment: Alignment.center,
            child: new Row(
              children: <Widget>[
                new Expanded(
                  child: new FlatButton(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20.0, horizontal: 20.0),
                    color: Colors.red[400],
                    onPressed: () => {},
                    child: Text(
                      "Register",
                      style: TextStyle(color: this.foregroundColor),
                    ),
                  ),
                ),
              ],
            ),
          ),
          new Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(
                left: 40.0, right: 40.0, top: 10.0, bottom: 20.0),
            alignment: Alignment.center,
            child: new Row(
              children: <Widget>[
                new Expanded(
                  child: new FlatButton(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20.0, horizontal: 20.0),
                    color: Colors.transparent,
                    onPressed: () => {
                      setState(() {
                        pressed = "LOGIN";
                      })
                    },
                    child: Text(
                      "Already have an account? Log In",
                      style: TextStyle(
                          color: this.foregroundColor.withOpacity(0.5)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          ToggleSwitch(
            minWidth: 90.0,
            initialLabelIndex: 1,
            cornerRadius: 20.0,
            activeFgColor: Colors.white,
            inactiveBgColor: Colors.grey,
            inactiveFgColor: Colors.white,
            labels: ['Rider', 'Client'],
            icons: [Icons.moped, Icons.person],
            activeBgColors: [Colors.blue, Colors.pink],
            onToggle: (index) {
              if (index == 0)
                typeOfUser = 'RIDER';
              else
                typeOfUser = 'CLIENT';
            },
          ),
        ],
      ),
    );
  }
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
            'To Arthur Shelby',
            textScaleFactor: 1.0,
            style: TextStyle(
                fontSize: 18.0,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
        ),
        Center(
          child: Text(
            'DETI 3810-193 Aveiro, 913 512 615',
            textScaleFactor: 1.0, 
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.white,
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
                child: Text(
                  "Vinho do Porto",
                  style: TextStyle(
                      color: Colors.white,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.white,
                      fontSize: 16),
                ),
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(40, 40, 61, 1),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text("Gin",
                    style: TextStyle(
                        color: Colors.white,
                        decoration: TextDecoration.underline,
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
                  "Vodka",
                  style: TextStyle(
                      color: Colors.white,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.white,
                      fontSize: 16),
                ),
              ),
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
            'Total: 34.06€',
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

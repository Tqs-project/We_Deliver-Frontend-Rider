import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';

class Profile extends StatefulWidget {
  Profile(this.title);
  String title;
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final Color? foregroundColor = Colors.grey[200];
  String typeOfTransport = "CAR";
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

          elevation: 0,
          brightness: Brightness.light,
          backgroundColor: Color.fromRGBO(40, 40, 61, 0.8),
          //automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(child: RiderHome(context)));
  }

  Widget RiderHome(BuildContext context) {
    return Container(
        height: (MediaQuery.of(context).size.height),
        decoration: BoxDecoration(
          color: Color.fromRGBO(31, 29, 47, 1),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[Profile(context), Statistics(context)],
        ));
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
                Color.fromRGBO(233, 86, 83, 1),
                Color.fromRGBO(233, 86, 83, 1),
                Color.fromRGBO(233, 86, 83, 1),
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
                  Text("19.3Km", style: TextStyle(color: Colors.white)),
                ],
              )),
          Divider(
            height: 10,
          ),
        ],
      ),
    ));
  }
}

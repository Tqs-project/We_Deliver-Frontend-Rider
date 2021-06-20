import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:wedeliver/Blocs/AuthenticationBloc.dart';
import 'package:wedeliver/Blocs/LocationBloc.dart';

// ignore: must_be_immutable
class Profile extends StatefulWidget {
  Profile(this.title, this.userData);
  String title;
  UserData userData;
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final Color? foregroundColor = Colors.grey[200];
  String typeOfTransport = 'CAR';
  var title = '';
  late UserData currentUser;
  String location = '';
  @override
  void initState() {
    super.initState();
    title = widget.title;
    currentUser = widget.userData;
    init();
  }

  void init() async {
    var address = await locationBloc.getAddressFromCoordinates();
    setState(() {
      location = address.addressLine;
    });
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
          children: <Widget>[
            Profile(context),
          ],
        ));
  }

  Widget Profile(BuildContext context) {
    return Center(
        child: Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.all(10),
      height: (MediaQuery.of(context).size.height) / 1.7,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        color: Color.fromRGBO(40, 40, 61, 0.8),
      ),
      child: ListView(
        children: [
          Hero(
              tag: 'Profile Picture',
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.red,
                    width: 1.0,
                  ),
                  shape: BoxShape.circle,
                  //image: DecorationImage(image: this.logo)
                ),
                child: Icon(
                  Icons.person,
                  size: 96,
                  color: Colors.white,
                ),
              )),
          Hero(
            tag: currentUser.riderData.username,
            child: Material(
              type: MaterialType.transparency,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Center(
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    initialValue: currentUser.riderData.username,
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
                child: Icon(Icons.email, color: Colors.red),
              ),
            ),
            initialValue: currentUser.riderData.email,
            style: TextStyle(color: Colors.white),
          ),
          TextFormField(
            decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.only(top: 20), // add padding to adjust text
              prefixIcon: Padding(
                padding: EdgeInsets.only(top: 15), // add padding to adjust icon
                child: Icon(Icons.car_repair, color: Colors.red),
              ),
            ),
            initialValue: currentUser.riderData.vehiclePlate,
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
            initialValue: currentUser.riderData.phonenumber,
            style: TextStyle(color: Colors.white),
          ),
          Divider(
            height: 20,
          ),
          Center(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.location_city, color: Colors.red),
              Text(
                location,
                style: TextStyle(color: Colors.white),
              )
            ],
          )),
          Divider(height: 10, thickness: 2, color: Colors.red),

          /*
          Center(
              // ignore: deprecated_member_use
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
          )),*/
        ],
      ),
    ));
  }
  /*
  Widget Statistics(BuildContext context) {
    return Expanded(
        child: Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.all(10),
      height: (MediaQuery.of(context).size.height) / 2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        color: Color.fromRGBO(40, 40, 61, 0.8),
      ),
      child: ListView(
        children: [
          Hero(
            tag: 'Statistics',
            child: Material(
              type: MaterialType.transparency,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Center(
                  child: Text(
                    'Statistics (Today)',
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
                  Text('Number Of Orders Accepted',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                  Text('12', style: TextStyle(color: Colors.white))
                ],
              )),
          Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total Profit',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                  Text('43€', style: TextStyle(color: Colors.white))
                ],
              )),
          Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Travelled Distance',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                  Text('19.3Km', style: TextStyle(color: Colors.white)),
                ],
              )),
          Divider(
            height: 10,
          ),
        ],
      ),
    ));
  }*/
}

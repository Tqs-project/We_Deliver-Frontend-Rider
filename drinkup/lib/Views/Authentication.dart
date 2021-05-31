import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';

class Authentication extends StatefulWidget {
  Authentication({Key? key}) : super(key: key);

  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  final Color foregroundColor = Colors.white;
  String typeOfTransport = "CAR";
  var pressed = 'LOGIN';
  var typeOfUser = 'RIDER';

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Authentication(context));
  }

  Widget Authentication(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          pressed == 'LOGIN' ? LoginPage() : RegisterPage(),
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
                        color: foregroundColor,
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
                    color: foregroundColor,
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
                    color: foregroundColor,
                  ),
                ),
                new Expanded(
                  child: TextField(
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Email',
                      hintStyle: TextStyle(color: foregroundColor),
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
                    color: foregroundColor,
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
                    color: foregroundColor,
                  ),
                ),
                new Expanded(
                  child: TextField(
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Name',
                      hintStyle: TextStyle(color: foregroundColor),
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
                    color: foregroundColor,
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
                    color: foregroundColor,
                  ),
                ),
                new Expanded(
                  child: TextField(
                    obscureText: true,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Password',
                      hintStyle: TextStyle(color: foregroundColor),
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
                    color: foregroundColor,
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
                    color: foregroundColor,
                  ),
                ),
                new Expanded(
                  child: TextField(
                    obscureText: true,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Confirm Password',
                      hintStyle: TextStyle(color: foregroundColor),
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
                    color: foregroundColor,
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
                    color: foregroundColor,
                  ),
                ),
                new Expanded(
                  child: TextField(
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'City',
                      hintStyle: TextStyle(color: foregroundColor),
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
                      style: TextStyle(color: foregroundColor),
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
                      style: TextStyle(color: foregroundColor.withOpacity(0.5)),
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
                        color: foregroundColor,
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
                    color: foregroundColor,
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
                    color: foregroundColor,
                  ),
                ),
                new Expanded(
                  child: TextField(
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Email',
                      hintStyle: TextStyle(color: foregroundColor),
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
                    color: foregroundColor,
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
                    color: foregroundColor,
                  ),
                ),
                new Expanded(
                  child: TextField(
                    obscureText: true,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Password',
                      hintStyle: TextStyle(color: foregroundColor),
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
                      style: TextStyle(color: foregroundColor),
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
                      style: TextStyle(color: foregroundColor.withOpacity(0.5)),
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
                      style: TextStyle(color: foregroundColor.withOpacity(0.5)),
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
}

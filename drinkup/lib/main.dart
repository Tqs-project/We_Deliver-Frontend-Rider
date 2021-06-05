import 'Blocs/LocationBloc.dart';
import 'Views/Authentication.dart';
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
    locationBloc.initialize();
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
  Main({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Authentication());
  }
}

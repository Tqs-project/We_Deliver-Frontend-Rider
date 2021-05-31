import 'locations.dart' as locations;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
  Main({Key? key, this.title}) : super(key: key);

  final String? title;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Drink Up"),
        ),
        body: Center(
            child: Container(
          decoration: BoxDecoration(
            color: Color.fromRGBO(31, 29, 47, 1),
          ),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                    width: MediaQuery.of(context).size.width /
                        1.05, // or use fixed size like 200
                    height: MediaQuery.of(context).size.height / 2.2,
                    child: gpsPage(context)),
                OrderDetails()
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
      ),
    );
  }
}

Widget OrderDetails() {
  return Container(
    alignment: Alignment.topCenter,
    margin: EdgeInsets.all(20),
    width: double.infinity,
    decoration: BoxDecoration(
      color: Color.fromRGBO(40, 40, 61, 1),
      borderRadius: BorderRadius.circular(30),
    ),
    child: SingleChildScrollView(
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
              textScaleFactor: 1.0, // disables accessibility
              style: TextStyle(
                fontSize: 30.0,
                color: Colors.white,
              ),
            ),
          ),
          Divider(
            height: 20,
            thickness: 2,
            color: Colors.red[400],
          ),
          ListView(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            padding: const EdgeInsets.all(8),
            children: <Widget>[
              Container(
                alignment: Alignment.topRight,
                margin: EdgeInsets.all(5.0),
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
                  ),
                ),
              ),
              Container(
                alignment: Alignment.topRight,
                margin: EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(40, 40, 61, 1),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  "Gin",
                  style: TextStyle(
                    color: Colors.white,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.white,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.topRight,
                margin: EdgeInsets.all(5.0),
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
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

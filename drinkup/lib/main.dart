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
  final Color? foregroundColor = Colors.grey[200];

  final Map<String?, Marker> _markers = {};
  Future<void> _onMapCreated(GoogleMapController controller) async {
    final casaPina = LatLng(40.643540, -8.655130);
    final universidade = LatLng(40.630690, -8.655130);
    /*  
    setState(() {
      _markers.clear();
      for (final office in googleOffices.offices!) {
        final marker = Marker(
          markerId: MarkerId(office.name!),
          position: LatLng(office.lat!, office.lng!),
          infoWindow: InfoWindow(
            title: office.name,
            snippet: office.address,
          ),
        );
        _markers[office.name] = marker;
      }
    });
    */
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: Text("Drink Up"),
      ),
      
      body: Center(child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          
          children: <Widget>[
            SizedBox(
                width: MediaQuery.of(context)
                    .size
                    .width/1.05, // or use fixed size like 200
                height: MediaQuery.of(context).size.height/2.2,
                child: gpsPage(context)),
                OrderDetails()
          ]),
    ));
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
          target: const LatLng(0, 0),
          zoom: 2,
        ),
        markers: _markers.values.toSet(),
      ),
    );
  }
}

Widget OrderDetails(){
  return Container(
      alignment: Alignment.topCenter,
      margin: EdgeInsets.all(20),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color.fromRGBO(111, 111, 164, 0.1),
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
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text( 'Order to Arthur Shelby from Garrafeira Martins'),
            ),
            Divider(
              height: 20,
              thickness: 2,
            ),
            ListView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              padding: const EdgeInsets.all(8),
              children: <Widget>[
                Text(
                  "Vinho do Porto"
                ),
              ],
            ),
          ],
        ),
      ),
    );
}
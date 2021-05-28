import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
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
  final Color foregroundColor = Colors.grey[200];
  int groupValue = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[OrderList(), CurrentOrder()],
      ),
    );
  }

  Widget OrderList() {
    return Container(
      alignment: Alignment.topCenter,
      margin: EdgeInsets.all(20),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
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
              child: GFListTile(
                titleText: 'Orders',
                subTitleText: 'Accept an Order',
              ),
            ),
            Divider(
              height: 40,
              thickness: 5,
            ),
            ListView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              padding: const EdgeInsets.all(8),
              children: <Widget>[
                GFRadioListTile(
                  titleText: 'Arthur Shelby',
                  subTitleText: 'By order of the peaky blinders',
                  avatar: GFAvatar(
                    backgroundImage: AssetImage('purchase-red.jpg'),
                  ),
                  size: 25,
                  activeBorderColor: Colors.green,
                  focusColor: Colors.green,
                  type: GFRadioType.square,
                  value: 0,
                  groupValue: groupValue,
                  onChanged: (value) {
                    setState(() {
                      groupValue = value;
                    });
                  },
                  inactiveIcon: null,
                ),
                GFRadioListTile(
                  titleText: 'Arthur Shelby',
                  subTitleText: 'By order of the peaky blinders',
                  avatar: GFAvatar(
                    backgroundImage: AssetImage('purchase-red.jpg'),
                  ),
                  size: 25,
                  activeBorderColor: Colors.green,
                  focusColor: Colors.green,
                  type: GFRadioType.square,
                  value: 1,
                  groupValue: groupValue,
                  onChanged: (value) {
                    setState(() {
                      groupValue = value;
                    });
                  },
                  inactiveIcon: null,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget CurrentOrder() {
    return Container(
      alignment: Alignment.topCenter,
      margin: EdgeInsets.all(20),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
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
      child: Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: GFListTile(
                titleText: 'Orders',
                subTitleText: 'Accept an Order',
                icon: ElevatedButton.icon(
                  onPressed: () {
                    // Respond to button press
                  },
                  icon: Icon(Icons.add, size: 18),
                  label: Text("Accept"),
                ),
              ),
            ),
            Divider(
              height: 40,
              thickness: 5,
            ),
            Center(
                child: Container(
              alignment: Alignment.topCenter,
              margin: EdgeInsets.all(20),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      child: Column(
                    children: [
                      Text(
                        'Orders',
                      ),
                      Text('Orders')
                    ],
                  )),
                  Expanded(
                      child: Column(
                    children: [
                      Text(
                        'Orders',
                      ),
                      Text('Orders')
                    ],
                  )),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}

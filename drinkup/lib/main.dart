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
        body: Container(
      decoration: BoxDecoration(
        color: Color.fromRGBO(31, 29, 47, 1),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[OrderList(), CurrentOrder()],
      ),
    ));
  }

  Widget OrderList() {
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
              child: GFListTile(
                titleText: 'Orders',
                subTitleText: 'Accept an Order',
              ),
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
                GFRadioListTile(
                  titleText: 'Arthur Shelby',
                  subTitleText: 'By order of the peaky blinders',
                  avatar: GFAvatar(
                    backgroundImage: AssetImage('purchase-red.jpg'),
                  ),
                  size: 25,
                  activeBorderColor: Colors.grey,
                  radioColor: Colors.red[300],
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
                  activeBorderColor: Colors.grey,
                  radioColor: Colors.red[300],
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
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          GFListTile(
            titleText: 'Current Order',
            icon: ElevatedButton.icon(
              onPressed: () {
                // Respond to button press
              },
              icon: Icon(Icons.add, size: 18),
              label: Text("Accept"),
            ),
          ),
          Divider(
            height: 20,
            thickness: 2,
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                    alignment: Alignment.topCenter,
                    margin: EdgeInsets.all(20),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.blueGrey[300],
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
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text("Order",
                              style: new TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16)),
                          Divider(
                            height: 5,
                            thickness: 5,
                          ),
                          ListView(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            padding: const EdgeInsets.all(8),
                            children: <Widget>[
                              GFListTile(
                                titleText: 'Vinho do Porto',
                                subTitleText: '1L',
                                avatar: GFAvatar(
                                  backgroundImage:
                                      AssetImage('purchase-red.jpg'),
                                ),
                              ),
                              GFListTile(
                                titleText: 'Eristoff Vodka',
                                subTitleText: '1.5L',
                                avatar: GFAvatar(
                                  backgroundImage:
                                      AssetImage('purchase-red.jpg'),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )),
              ),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text("User Details",
                        style: new TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    Divider(
                      height: 5,
                      thickness: 5,
                    ),
                    ListView(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(8),
                      children: <Widget>[
                        GFListTile(
                          titleText: 'Arthur Shelby',
                          subTitleText: '4Km Away',
                        ),
                        GFListTile(
                          subTitleText: 'Address: ---------',
                        ),
                        GFListTile(
                          subTitleText: 'Phone Number: 913 514 255',
                        ),
                        Divider(
                          height: 5,
                          thickness: 5,
                        ),
                        Text(
                          "Total: 31,4€",
                          textAlign: TextAlign.right,
                        )
                      ],
                    ),
                  ],
                ),
              ))
            ],
          )
        ]));
  }
}

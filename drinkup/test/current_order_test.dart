import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wedeliver/Blocs/AuthenticationBloc.dart';
import 'package:wedeliver/Entities/LoginData.dart';
import 'package:wedeliver/Entities/Order.dart';
import 'package:wedeliver/Entities/Rider.dart';
import 'package:wedeliver/Views/CurrentOrder.dart';

import 'package:wedeliver/main.dart';

void main() {
  Widget createWidgetForTesting(Widget child) {
    return MaterialApp(
      home: child,
    );
  }

  testWidgets('CurrentOrder Test', (WidgetTester tester) async {
    var order = Order(
        0,
        DateTime.now(),
        'CARD',
        'DELIVERED',
        3.06,
        'R. Antónia Rodrigues 36, 3800-102 Aveiro',
        '3810-193 Aveiro',
        'username',
        '0');

    var userData = UserData(
        LoginData('TOKEN', 'ERROR'), Rider.loginData('username', 'password'));

    await tester.pumpWidget(
        createWidgetForTesting(CurrentOrder('WeDeliver', userData, order)));

    // Verify that our counter starts at 0.
    expect(
        find.text(
          'Order Details',
        ),
        findsOneWidget);
    expect(find.text('Profit: 3.06€'), findsOneWidget);
    expect(find.text('username'), findsWidgets);
    expect(find.text('From R. Antónia Rodrigues 36, 3800-102 Aveiro'),
        findsOneWidget);
    expect(find.text('To 3810-193 Aveiro'), findsOneWidget);
  });
}

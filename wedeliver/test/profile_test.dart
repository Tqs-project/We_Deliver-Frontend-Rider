import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' show Client;
import 'package:wedeliver/Blocs/AuthenticationBloc.dart';
import 'package:wedeliver/Entities/LoginData.dart';
import 'package:wedeliver/Entities/Rider.dart';
import 'package:wedeliver/Views/Profile.dart';

import 'package:wedeliver/main.dart';

class MockClient extends Mock implements Client {}

void main() {
  Widget createWidgetForTesting(Widget child) {
    return MaterialApp(
      home: child,
    );
  }

  testWidgets('Profile Frontend Test', (WidgetTester tester) async {
    var userData = UserData(LoginData('TOKEN', 'ERROR'),
        Rider.json(0, 'username', 'email', 'phonenumber', 'vehicleplate'));
    // Build our app and trigger a frame.
    await tester
        .pumpWidget(createWidgetForTesting(Profile('WeDeliver', userData)));

    // Verify that our counter starts at 0.
    expect(find.text('username'), findsOneWidget);
    expect(find.text('email'), findsOneWidget);
    expect(find.text('phonenumber'), findsOneWidget);
    expect(find.text('vehicleplate'), findsOneWidget);
  });
}

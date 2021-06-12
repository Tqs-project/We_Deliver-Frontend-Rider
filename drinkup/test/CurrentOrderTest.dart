import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:wedeliver/main.dart';

void main() {
  testWidgets('CurrentOrder Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Verify that our counter starts at 0.
    expect(
        find.text(
          'Order Details',
        ),
        findsOneWidget);
    expect(find.byType(GoogleMap), findsOneWidget);
    expect(find.text('Profit'), findsOneWidget);
    expect(find.text('Register'), findsNothing);
    expect(
        find.text('R. Antónia Rodrigues 36, 3800-102 Aveiro'), findsOneWidget);
    expect(find.text('DETI 3810-193 Aveiro'), findsOneWidget);
  });
}

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sri_cuisine/pages/updateprofilepage.dart'; 

void main() {
  testWidgets('UpdateProfilePage Widget Test', (WidgetTester tester) async {
    // Build our widget and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(
        home: UpdateProfilePage()
      )
    );

    // Verify that the app bar contains the correct title and icon.
    expect(find.text('Edit Profile'), findsOneWidget);
    expect(find.byIcon(Icons.edit), findsOneWidget);

    // Verify that the text fields are present.
    expect(find.text('Username'), findsOneWidget);
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Height (cm)'), findsOneWidget);
    expect(find.text('Weight (kg)'), findsOneWidget);

    // Tap on the save button and verify if it's working.
    await tester.tap(find.text('Save'));
    await tester.pump();

    // Add more test cases as needed to verify the functionality.
  });
}




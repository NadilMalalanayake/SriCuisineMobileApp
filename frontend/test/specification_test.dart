import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sri_cuisine/pages/specification_page.dart'; // Import your SpecPage widget

void main() {
  testWidgets('SpecPage Widget Test', (WidgetTester tester) async {
    // Build the SpecPage widget and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: SpecPage(),
    ));

    // Verify if the SpecPage UI elements are rendered
    expect(find.text('Allergies & Specifications'), findsOneWidget);
    expect(find.text('Select Your Allergies'), findsOneWidget);
    expect(find.text('Height (cm)'), findsOneWidget);
    expect(find.text('Weight (kg)'), findsOneWidget);
    expect(find.text('Age (years)'), findsOneWidget);
    expect(find.text('Save'), findsOneWidget);
    expect(find.text('Male'), findsOneWidget);
    expect(find.text('Female'), findsOneWidget);

    // Perform a tap on the Save button and verify if it triggers the save action
    await tester.enterText(find.byType(TextField).at(0), '170'); // Enter height
    await tester.enterText(find.byType(TextField).at(1), '70');  // Enter weight
    await tester.enterText(find.byType(TextField).at(2), '30');  // Enter age
    await tester.tap(find.text('Male'));  // Select gender
    await tester.tap(find.text('Save')); // Tap Save button
    await tester.pump(); // Wait for the save action to complete
    // Assert the save action, you may need to check for any expected navigation or UI updates
    // depending on what the save action does in your application.

    // Add more test cases as needed
  });
}

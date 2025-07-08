import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sri_cuisine/pages/BMIScreen.dart'; // Import the BMIPageScreen page

void main() {
  testWidgets('BMIScreen Widget Test', (WidgetTester tester) async {
    // Build the BMIPageScreen widget and trigger a frame.
    var tester2 = tester;
    await tester2.pumpWidget(MaterialApp(
      home: BMIPageScreen(),
    ));

    // Verify if the BMIPageScreen UI elements are rendered
    expect(find.text('BMI & Calculator'), findsOneWidget);
    expect(find.text('Height (cm)'), findsOneWidget);
    expect(find.text('Weight (kg)'), findsOneWidget);
    expect(find.text('Age (years)'), findsOneWidget);
    expect(find.text('Calculate BMI'), findsOneWidget);
    expect(find.text('Male'), findsOneWidget);
    expect(find.text('Female'), findsOneWidget);

    // Perform a tap on the Calculate BMI button and verify if it updates the BMI
    await tester.enterText(find.byType(TextField).at(0), '170'); // Enter height
    await tester.enterText(find.byType(TextField).at(1), '70');  // Enter weight
    await tester.enterText(find.byType(TextField).at(2), '30');  // Enter age
    await tester.tap(find.text('Male'));  // Select gender
    await tester.tap(find.text('Calculate BMI')); // Tap Calculate BMI button
    await tester.pump(); // Wait for the BMI calculation to complete
    // Assert the BMI value
    expect(find.text('BMI: '), findsOneWidget); // Check if BMI text is present

    // Add more test cases as needed
  });
}

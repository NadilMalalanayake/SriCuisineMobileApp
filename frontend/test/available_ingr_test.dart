import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sri_cuisine/pages/available_ingredients_screen.dart'; // Import your screen file

void main() {
  testWidgets('AvailableIngredientsScreen Widget Test', (WidgetTester tester) async {
    // Build our app and trigger a frame
    await tester.pumpWidget(MaterialApp(home: AvailableIngredientsScreen()));

    // Verify that the title 'Available Ingredients' is displayed
    expect(find.text('Available Ingredients'), findsOneWidget);

    // Verify that the initial state has no ingredient selected
    expect(find.byType(CheckboxListTile), findsNothing);

    // Tap on the first category to expand ingredients list
    await tester.tap(find.text('Vegetables'));
    await tester.pump();

    // Verify that the ingredients list is displayed after tapping on a category
    expect(find.byType(CheckboxListTile), findsWidgets);

    // Tap on an ingredient to select it
    await tester.tap(find.byType(CheckboxListTile).first);
    await tester.pump();

    // Verify that the ingredient is selected
    expect(find.byIcon(Icons.calendar_today), findsOneWidget);

    // Tap on the 'Save Ingredients' button
    await tester.tap(find.text('Save Ingredients'));
    await tester.pump();

    // Verify that the ingredient is saved and the selected ingredient list is cleared
    expect(find.byType(SnackBar), findsOneWidget);
  });
}

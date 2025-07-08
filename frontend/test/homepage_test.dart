import 'package:flutter/material.dart';
import 'package:sri_cuisine/components/poprecipelist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sri_cuisine/pages/home_page.dart';

void main() {
  var description = 'HomePage Widget Test';
  testWidgets(description, (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: HomePage()));

    // Verify that the home page contains the app bar with the title 'Home'
    expect(find.text('Home'), findsOneWidget);

    // Verify that the BMI and Calorie widgets are present
    expect(find.text('Your BMI'), findsOneWidget);
    expect(find.text('Your Daily'), findsOneWidget);
    
    // Verify that the BMI & Calorie Intake Calculator button is present
    expect(find.text('BMI & Calorie Intake Calculator'), findsOneWidget);

    // Verify that the PopRecipesList widget is present
    expect(find.byType(PopRecipesList), findsOneWidget);
  });
}

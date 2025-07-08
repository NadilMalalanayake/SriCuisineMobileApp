import 'package:flutter/material.dart';
import 'package:sri_cuisine/pages/login.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sri_cuisine/pages/signup.dart'; // Import the SignupPage page

void main() {
  var description = 'SignupPage Widget Test';
  testWidgets(description, (tester) async {
    // Build the SignupPage widget and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: SignupPage(),
    ));

    // Verify if the SignupPage UI elements are rendered
    expect(find.text('Sign up'), findsOneWidget);
    expect(find.text('UserName'), findsOneWidget);
    expect(find.text('Email Address'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.text('Already have an Account?'), findsOneWidget);
    expect(find.text('Log in'), findsOneWidget);

    // Perform a tap on the Sign up button and verify if it triggers navigation
    await tester.tap(find.text('Sign up'));
    await tester.pumpAndSettle(); // Wait for navigation to complete
    // Assert the page navigation after Sign up button is tapped
    // You may need to change this assertion based on your app's navigation logic
    expect(find.byType(LoginPage), findsOneWidget);
  });

  // Add more test cases as needed
}


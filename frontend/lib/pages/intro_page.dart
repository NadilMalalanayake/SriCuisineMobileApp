// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sri_cuisine/pages/welcomepage.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(
        Duration(seconds: 3),
        () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => WelcomePage())));
    return Scaffold(
        backgroundColor: Colors.yellow,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Center(
              child: Image(
                image: AssetImage('images/introimage.jpg'),
              ),
            ),

            SizedBox(height: 20),
            CircularProgressIndicator(color: Colors.black),
          ],
        ));
  }
}

 // home: Scaffold(
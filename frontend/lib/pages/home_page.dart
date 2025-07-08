import 'package:flutter/material.dart';
import 'package:sri_cuisine/components/home_appbar.dart';
import 'package:sri_cuisine/components/poprecipelist.dart';
import 'package:sri_cuisine/pages/BMIScreen.dart';
import 'package:sri_cuisine/services/UserApi.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomePage> {
  var bmi = 0.0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bmi = UserApi.user.weight! /
        ((UserApi.user.height! / 100) * (UserApi.user.height! / 100));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Icon(Icons.home), SizedBox(width: 10), Text('Home')]),
      ),
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HomeAppbar(),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Container(
                      // width: 170,
                      // height: 170,
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.grey[300],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Your BMI\n${bmi.toStringAsFixed(2)}kg/m2",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 30),
                    Container(
                      // width: 170,
                      // height: 170,
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.grey[300],
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Your Daily \nCalorie Intake\n2250 kcal/day",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BMIPageScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.yellow[100],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0),
                      ),
                    ),
                    child: const Text('BMI & Calorie Intake Calculator'),
                  ),
                ),
                const SizedBox(height: 20),
                const PopRecipesList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

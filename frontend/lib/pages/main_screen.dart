import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sri_cuisine/pages/available_ingredients_screen.dart';
import 'package:sri_cuisine/pages/home_page.dart';
import 'package:sri_cuisine/pages/profile_page.dart';
import 'package:sri_cuisine/pages/recipes_page.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreen createState() => _MainScreen();
}

class _MainScreen extends State<MainScreen> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    const Scaffold(
      body: HomePage(),
    ),
    Scaffold(
      body: AvailableIngredientsScreen(),
    ),
    Scaffold(
      body: RecipesPage(),
    ),
    const Scaffold(
      body: ProfilePage(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        color: Colors.grey.shade900,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: GNav(
            gap: 10,
            backgroundColor: Colors.grey.shade900,
            color: Colors.yellow,
            activeColor: Colors.black,
            tabBackgroundColor: Colors.yellow.shade100,
            padding: const EdgeInsets.all(16),
            tabs: const [
              GButton(
                icon: Icons.home,
                text: 'Home',
              ),
              GButton(
                icon: CupertinoIcons.square_grid_2x2_fill,
                text: 'Ingredients',
              ),
              GButton(
                icon: Icons.restaurant_menu,
                text: 'Recipes',
              ),
              GButton(
                icon: Icons.person,
                text: 'Profile',
              ),
            ],
            selectedIndex: _selectedIndex,
            onTabChange: (index) => setState(() => _selectedIndex = index),
          ),
        ),
      ),
    );
  }
}

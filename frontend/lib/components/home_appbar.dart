import 'package:flutter/material.dart';
import 'package:sri_cuisine/services/IngredientApi.dart';
import 'package:iconsax/iconsax.dart';

class HomeAppbar extends StatelessWidget {
  const HomeAppbar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: const Image(
            image: AssetImage("assets/images/appLogoWhite.jpg"),
            width: 100,
            height: 100,
          ),
        ),
        const Text(
          "Welcome to\n  SriCuisine!",
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            height: 1,
          ),
        ),
        // const Spacer(),
        IconButton(
          onPressed: () {
            IngridientApi.getIngredient(context);
          },
          style: IconButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            backgroundColor: Colors.white,
            fixedSize: const Size(55, 55),
          ),
          icon: const Icon(Iconsax.notification),
        ),
      ],
    );
  }
}

// class AvailableIngredientsScreen extends StatefulWidget {
//   @override
//   _AvailableIngredientsScreenState createState() =>
//       _AvailableIngredientsScreenState();
// }

// class _AvailableIngredientsScreenState
//     extends State<AvailableIngredientsScreen> {
//   // Your existing code for ingredient selection and recipe generation

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.yellow,
      title: const Text(
        'Available Ingredients',
        style: TextStyle(color: Colors.black),
      ),
      centerTitle: true,
    ),
    body: const Column(
      children: [
        HomeAppbar(), // Adding HomeAppbar here
        // Your existing code for ingredient selection
      ],
    ),
  );
}

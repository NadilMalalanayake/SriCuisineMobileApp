import 'package:flutter/material.dart';
import 'package:sri_cuisine/models/popularrecipe.dart';
import 'package:sri_cuisine/pages/popularrecipepage.dart';
import 'package:iconsax/iconsax.dart';

class PopRecipesList extends StatelessWidget {
  const PopRecipesList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Popular Sri Lankan Dishes",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(
              popularrecipes.length,
              (index) => GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        PopularRecipePage(popularrecipe: popularrecipes[index]),
                  ),
                ),
                child: Container(
                  margin: const EdgeInsets.only(right: 10),
                  width: 200,
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
                            height: 130,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                image: AssetImage(popularrecipes[index].image),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            popularrecipes[index].name,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              const Icon(
                                Iconsax.flash_1,
                                size: 18,
                                color: Colors.black,
                              ),
                              Text(
                                "${popularrecipes[index].cal} Cal",
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                ),
                              ),
                              const Text(
                                " · ",
                                style: TextStyle(color: Colors.black),
                              ),
                              const Icon(
                                Iconsax.clock,
                                size: 18,
                                color: Colors.black,
                              ),
                              Text(
                                "${popularrecipes[index].time} Min",
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

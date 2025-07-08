import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sri_cuisine/components/recipe_card.dart';
import 'package:sri_cuisine/models/recipe.dart';
import 'package:sri_cuisine/pages/recipe_detail_page.dart';
import 'package:sri_cuisine/services/IngredientApi.dart';

class RecipesPage extends StatefulWidget {
  @override
  _Recipes createState() => _Recipes();
}

class _Recipes extends State<RecipesPage> {
  List<Recipe> recipesList = IngridientApi.recipeList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.restaurant_menu),
              SizedBox(width: 10),
              Text('Recommended Recipes')
            ]),
      ),
      body: recipesList.isEmpty
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: CupertinoActivityIndicator(
                    color: Colors.grey.shade900,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Add Ingredients for Personalized Recepies",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                )
              ],
            )
          : ListView.builder(
              itemCount: recipesList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RecipeDetailPage(
                          recipe: recipesList[index],
                        ),
                      ),
                    );
                  },
                  child: RecipeCard(
                    recipe: recipesList[index],
                    title: ("${recipesList[index].recipeName}"),
                    thumbnailUrl: ("${recipesList[index].image}"),
                    calorie: ("${recipesList[index].calorie}"),
                    cookTime: ("${recipesList[index].totalTimeInMins}"),
                  ),
                );
              },
            ),
    );
  }
}

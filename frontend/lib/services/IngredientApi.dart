import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sri_cuisine/components/snackbar.dart';
import 'package:sri_cuisine/models/ingredient.dart';
import 'package:sri_cuisine/models/recipe.dart';
import 'package:sri_cuisine/pages/trackerpage.dart';
import 'package:sri_cuisine/routes/api_routes.dart';
import 'package:sri_cuisine/services/UserApi.dart';
import 'package:http/http.dart' as http;

class IngridientApi {
  static List<Ingredient> expiredIngredients = [];
  static List<Ingredient> sevenDayExpireIngredients = [];
  static List<Ingredient> threeDayExpireIngredients = [];
  static List<Ingredient> todayExpireIngredients = [];

  static Future<void> createBatchIngredient(
      BuildContext context, List<Map<String, dynamic>> ingredientData) async {
    List<Map<String, dynamic>> body = ingredientData;
    try {
      final response = await http.post(
        Uri.parse(
            '${ApiRoutes.BASE_URL}ingredients/batch'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(body),
      );
      print(response.body);
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          errorSnackBar(json.decode(response.body)['message']),
        );
      }
    } catch (e) {
      print(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        errorSnackBar(e.toString()),
      );
    }
  }

  static Future<void> getIngredient(
    BuildContext context,
  ) async {
    Map<String, dynamic> body = {
      'userId': UserApi.user.id,
    };
    expiredIngredients = [];
    sevenDayExpireIngredients = [];
    threeDayExpireIngredients = [];
    todayExpireIngredients = [];
    try {
      final response = await http.post(
        Uri.parse(
            '${ApiRoutes.BASE_URL}ingredients/get/'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(body),
      );
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData['expiringToday'].isNotEmpty) {
          for (int i = 0; i < responseData['expiringToday'].length; i++) {
            todayExpireIngredients
                .add(Ingredient.fromJson(responseData['expiringToday'][i]));
          }
        }
        if (responseData['expiringIn3Days'].isNotEmpty) {
          for (int i = 0; i < responseData['expiringIn3Days'].length; i++) {
            threeDayExpireIngredients
                .add(Ingredient.fromJson(responseData['expiringIn3Days'][i]));
          }
        }
        if (responseData['expiringIn7Days'].isNotEmpty) {
          for (int i = 0; i < responseData['expiringIn7Days'].length; i++) {
            sevenDayExpireIngredients
                .add(Ingredient.fromJson(responseData['expiringIn7Days'][i]));
          }
        }
        if (responseData['expired'].isNotEmpty) {
          for (int i = 0; i < responseData['expired'].length; i++) {
            expiredIngredients
                .add(Ingredient.fromJson(responseData['expired'][i]));
          }
        }
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TrackerPage()),
        );
        for (Ingredient ingredient in todayExpireIngredients) {
          print(ingredient.toJson());
        }
        for (Ingredient ingredient in threeDayExpireIngredients) {
          print(ingredient.toJson());
        }
        for (Ingredient ingredient in sevenDayExpireIngredients) {
          print(ingredient.toJson());
        }
        for (Ingredient ingredient in expiredIngredients) {
          print(ingredient.toJson());
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          errorSnackBar(json.decode(response.body)['message']),
        );
      }
    } catch (e) {
      print(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        errorSnackBar(e.toString()),
      );
    }
  }

  static List<Recipe> recipeList = [];

  Future<void> postAvailableIngredients(List selectedIngredients) async {
    var userId = UserApi.userId;
    try {
      final Map<String, dynamic> requestBody = {
        '_id': userId,
        'user_ingredients': selectedIngredients,
      };

      var url = Uri.parse(ApiRoutes.BASE_URL_INGREDIENTS);

      var body = jsonEncode(requestBody);

      var request = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: body,
      );

      if (request.statusCode == 200) {
        print(request.body);
        // print(request.statusCode);

        // recipeList = request.body;

        // Clear the existing recipeList before adding new items

        // recipeList.forEach((recipeJson) {
        //   Recipe recipe = Recipe.fromJson(recipeJson);
        //   recipeList.add(recipe);

        //   var jsonResponse = jsonDecode(response.body);
        //   List<dynamic> recipeJsonList = jsonResponse as List<dynamic>;

        //   // Clear the existing recipeList before adding new items
        //   recipeList.clear();

        //   recipeJsonList.forEach((recipeJson) {
        //     Recipe recipe = Recipe.fromJson(recipeJson);
        //     recipeList.add(recipe);
        //   });

        //   print(recipeList);
        // });

        print(request.body);
        print(request.statusCode);
        // Parse the JSON response into a List<Recipe>
        List<dynamic> jsonResponse = jsonDecode(request.body);
        recipeList = jsonResponse.map((e) => Recipe.fromJson(e)).toList();
        print(recipeList.length);
        print(recipeList);

        // var jsonResponse = jsonDecode(request.body);
        // List<dynamic> recipeJsonList = jsonResponse as List<dynamic>;

        // // Clear the existing recipeList before adding new items
        // recipeList.clear();

        // recipeJsonList.forEach((recipeJson) {
        //   Recipe recipe = Recipe.fromJson(recipeJson);
        //   recipeList.add(recipe);
        // });
      } else {
        print('Failed to load  Data');
      }
    } catch (e) {
      throw Exception('Failed to load data: $e');
    }
  }
}

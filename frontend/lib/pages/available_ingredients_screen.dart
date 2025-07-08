import 'package:flutter/material.dart';
import 'package:sri_cuisine/services/IngredientApi.dart';
import 'package:sri_cuisine/services/UserApi.dart';

class AvailableIngredientsScreen extends StatefulWidget {
  @override
  _AvailableIngredientsScreenState createState() =>
      _AvailableIngredientsScreenState();
}

class _AvailableIngredientsScreenState
    extends State<AvailableIngredientsScreen> {
  int _selectedIndex = -1;

  List<Map<String, dynamic>> ingredientData = [];

  final List<String> _categories = [
    'Vegetables',
    'Meats',
    'Fruits',
    'Staples',
  ];

  final List<List<String>> _ingredients = [
    // Vegetables
    [
      'Mushrooms',
      'Raddish',
      'Cauliflower',
      'Broccoli',
      'Egg-plant',
      'Spinach',
      'Cucumber',
      'Bell Pepper',
      'Bitter-Gourd',
      'Tomatoes',
      'Carrots',
      'Green Beans',
      'Pumpkin',
      'Cabbage',
      'Potatoes',
      'Coriander',
    ],
    // Meats
    [
      'Chicken',
      'Pork',
      'Fish',
      'Beef',
      'Lamb',
      'Prawns',
      'Crab',
      'Clamps',
    ],
    // Fruits
    [
      'Apple',
      'Avocados',
      'Bananas',
      'Jackfruit',
      'Lemon',
      'Mango',
      'Pineapple',
      'Pomegranate',
    ],
    // Staples
    [
      'Gram Flour',
      'Wheat Flour',
      'Rice',
      'Noodle',
      'Dhal',
      'Ghee',
      'Milk',
      'Nuts',
      'Eggs',
      'Chickpeas',
      'Greenpeas',
      'Coconut',
    ],
  ];

  List<Map<String, dynamic>> _selectedIngredients = [];
  bool _showIngredients = false;

  void _onCategoryTapped(int index) {
    setState(() {
      if (_selectedIndex == index) {
        _showIngredients = !_showIngredients;
      } else {
        _selectedIndex = index;
        _showIngredients = true;
      }
    });
  }

  void _onIngredientSelected(String ingredient) async {
    final existingIndex =
        _selectedIngredients.indexWhere((item) => item['name'] == ingredient);

    if (existingIndex == -1) {
      final DateTime? selectedDate = await _selectDate(context);
      if (selectedDate != null) {
        final Map<String, dynamic> ingredientMap = {
          'name': ingredient,
          'date': selectedDate,
        };
        _selectedIngredients.add(ingredientMap);
      }
    } else {
      _selectedIngredients.removeAt(existingIndex);
    }
    List ingredientNames =
        _selectedIngredients.map((item) => item['name']).toList();

    // Print the list of ingredient names
    print(ingredientNames);

    IngridientApi().postAvailableIngredients(ingredientNames);
    setState(() {});
    print(existingIndex);
  }

  Future<DateTime?> _selectDate(BuildContext context) async {
    return await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime(2030),
    );
  }

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
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                final category = _categories[index];
                final isSelected = _selectedIndex == index;
                return Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        _onCategoryTapped(index);
                      },
                      child: Card(
                        elevation: isSelected ? 4 : 2,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? const Color(0xFFE0E0E0)
                                : const Color(0xFFE0E0E0),
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: isSelected
                                ? [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 1,
                                      blurRadius: 3,
                                      offset: const Offset(0, 1),
                                    ),
                                  ]
                                : [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 1,
                                      blurRadius: 3,
                                      offset: const Offset(0, 1),
                                    ),
                                  ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                category,
                                style: TextStyle(
                                  color:
                                      isSelected ? Colors.blue : Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Icon(
                                isSelected
                                    ? _showIngredients
                                        ? Icons.arrow_drop_up
                                        : Icons.arrow_drop_down
                                    : null,
                                color: isSelected ? Colors.blue : Colors.black,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: isSelected && _showIngredients,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 0),
                        curve: Curves.easeInOut,
                        height: _showIngredients
                            ? MediaQuery.of(context).size.height * 0.3
                            : 0,
                        child: Center(
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: _ingredients[index]
                                  .map(
                                    (ingredient) => Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          _onIngredientSelected(ingredient);
                                        },
                                        child: CheckboxListTile(
                                          title: Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  '$ingredient ${_selectedIngredients.where((item) => item['name'] == ingredient).isNotEmpty ? '- ${_selectedIngredients.firstWhere((item) => item['name'] == ingredient)['date'].toString().substring(0, 10)}' : ''}',
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                    color: _selectedIngredients
                                                            .any((element) =>
                                                                element[
                                                                    'name'] ==
                                                                ingredient)
                                                        ? Colors.blue
                                                        : Colors.black,
                                                  ),
                                                ),
                                              ),
                                              IconButton(
                                                onPressed: () {
                                                  _onIngredientSelected(
                                                      ingredient);
                                                },
                                                icon: Icon(
                                                  Icons.calendar_today,
                                                  color: _selectedIngredients
                                                          .any((element) =>
                                                              element['name'] ==
                                                              ingredient)
                                                      ? Colors.blue
                                                      : Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                          value: _selectedIngredients.any(
                                              (element) =>
                                                  element['name'] ==
                                                  ingredient),
                                          onChanged: (value) {
                                            _onIngredientSelected(ingredient);
                                          },
                                          controlAffinity:
                                              ListTileControlAffinity.leading,
                                          activeColor: Colors.blue,
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.grey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                ),
                onPressed: () {
                  // Placeholder for scanner
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.qr_code, color: Colors.black), // Scanner Icon
                    SizedBox(width: 10), // Spacer
                    Text(
                      'Scan the Ingredients',
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.yellow,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                ),
                onPressed: () {
                  // Placeholder for recipe generation
                  if (_selectedIngredients.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Please select ingredients to generate recipes',
                          textAlign: TextAlign.center,
                        ),
                        backgroundColor: Colors.red,
                      ),
                    );
                  } else {
                    for (final ingredient in _selectedIngredients) {
                      ingredientData.add({
                        'user': UserApi.user.id,
                        'name': ingredient['name'],
                        'expiryDate':
                            ingredient['date'].toString().substring(0, 10),
                      });
                      print(ingredient);
                    }
                    print(ingredientData);
                    IngridientApi.createBatchIngredient(
                        context, ingredientData);
                    ingredientData.clear();
                    _selectedIngredients.clear();
                    setState(() {});
                  }
                },
                child: const Text(
                  'Save Ingredients',
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

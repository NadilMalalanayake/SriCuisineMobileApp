import 'package:flutter/material.dart';
import 'package:sri_cuisine/models/ingredient.dart';
import 'package:sri_cuisine/services/IngredientApi.dart';
import 'package:intl/intl.dart';

class TrackerPage extends StatefulWidget {
  TrackerPage({Key? key}) : super(key: key);

  @override
  _TrackerPageState createState() => _TrackerPageState();
}

class _TrackerPageState extends State<TrackerPage> {
  List<Ingredient>? selectedExpiryDates;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: const Text(
          'Expiry Dates',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 16),
            _buildCategory(
                'Expired', IngridientApi.expiredIngredients, Colors.black),
            const SizedBox(height: 16),
            _buildCategory('Expiring Today',
                IngridientApi.todayExpireIngredients, Colors.red),
            const SizedBox(height: 16),
            _buildCategory('Expiring In 3 Days',
                IngridientApi.threeDayExpireIngredients, Colors.orange),
            const SizedBox(height: 16),
            _buildCategory('Expiring In 7 Days',
                IngridientApi.sevenDayExpireIngredients, Colors.green),
          ],
        ),
      ),
    );
  }

  Widget _buildCategory(
    String title,
    List<Ingredient> items,
    Color color,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            setState(() {
              selectedExpiryDates = items;
            });
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(color),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
            elevation: MaterialStateProperty.all<double>(8), // Adjust elevation
            shadowColor: MaterialStateProperty.all<Color>(
                Colors.grey), // Add shadow color
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.white, // Text color
                fontWeight: FontWeight.bold, // Bold text
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        if (selectedExpiryDates == items)
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 8),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return Text(
                      '${items[index].name} - ${DateFormat('yyyy-MM-dd').format(DateTime.parse(items[index].expiryDate.toString()))}',
                      style: const TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    );
                  },
                ),
              ],
            ),
          ),
      ],
    );
  }
}

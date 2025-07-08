import 'package:flutter/material.dart';
import 'package:sri_cuisine/services/UserApi.dart';

class SpecPage extends StatefulWidget {
  @override
  State<SpecPage> createState() => _SpecPageState();
}

class _SpecPageState extends State<SpecPage> {
  final _formfield = GlobalKey<FormState>();
  final heightController = TextEditingController();
  final weightController = TextEditingController();
  final ageController = TextEditingController();

  List<String> allergens = [];

  bool passToggle = true;

  //checkbox
  List<Map<String, dynamic>> availableSpecification = [
    {
      "name": "Dairy",
      "description": "Includes milk and milk-based products",
      "isChecked": false
    },
    {
      "name": "Gluten",
      "description": "Found in wheat, rye, barley, and their derivatives",
      "isChecked": false
    },
    {
      "name": "Eggs",
      "description": "Refers to egg and egg-based products",
      "isChecked": false
    },
    {
      "name": "Fish",
      "description": "Includes fish and fish-based products",
      "isChecked": false
    },
    {
      "name": "Prawn",
      "description": "Includes prawn and prawn-based products.",
      "isChecked": false
    },
    {
      "name": "Nuts",
      "description": "Includes various tree nuts such as almonds,walnuts, etc.",
      "isChecked": false
    },
  ];

  String _selectedGender = 'Male';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Center(
          child: Text(
            "Allergies & Specifications",
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            )
          ),
        ),
        backgroundColor: Colors.yellow,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formfield,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const SizedBox(height: 10),
                const Center(
                  child: Text(
                    "Select Your Allergies",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Column(
                  children: availableSpecification.map((subj) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: Card(
                        elevation: 3,
                        color: Colors.grey[200], // Grey color for card
                        child: CheckboxListTile(
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 20),
                          value: subj["isChecked"],
                          title: Text(
                            subj["name"],
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            subj["description"],
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                          onChanged: (newValue) {
                            if (allergens
                                .contains(subj["name"])) {
                              allergens.remove(subj["name"]);
                            } else {
                              allergens.add(subj["name"]);
                            }
                            setState(() {
                              subj["isChecked"] = newValue;
                            });
                          },
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(height: 10),
                const Center(
                  child: Text(
                    " Height,Weight & Age",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Wrap(
                  children: availableSpecification.map((subj) {
                    if (subj["isChecked"] == true) {}
                    return Container();
                  }).toList(),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: heightController,
                  decoration: InputDecoration(
                    labelText: 'Height (cm)',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  validator: (value) {
                    bool heightValid = RegExp(r'^\d{2,3}$').hasMatch(value!);

                    if (value.isEmpty) {
                      return "Enter user Height";
                    } else if (!heightValid) {
                      return "Enter Valid user Height";
                    }
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: weightController,
                  decoration: InputDecoration(
                    labelText: 'Weight (kg)',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  validator: (value) {
                    bool weightValid = RegExp(r'^\d{2,3}$').hasMatch(value!);

                    if (value.isEmpty) {
                      return "Enter user Weight";
                    } else if (!weightValid) {
                      return "Enter Valid user Weight";
                    }
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: ageController,
                  decoration: InputDecoration(
                    labelText: 'Age (years)',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  validator: (value) {
                    bool ageValid =
                        RegExp(r'^(?:[1-9][0-9]?|100)$').hasMatch(value!);

                    if (value.isEmpty) {
                      return "Enter user Age";
                    } else if (!ageValid) {
                      return "Enter Valid user Age";
                    }
                  },
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Radio<String>(
                      value: 'Male',
                      groupValue: _selectedGender,
                      onChanged: (value) {
                        setState(() {
                          _selectedGender = value!;
                        });
                      },
                    ),
                    const Text('Male'),
                    Radio<String>(
                      value: 'Female',
                      groupValue: _selectedGender,
                      onChanged: (value) {
                        setState(() {
                          _selectedGender = value!;
                        });
                      },
                    ),
                    const Text('Female'),
                  ],
                ),
                const SizedBox(height: 20),
                InkWell(
                  onTap: () {
                    if (_formfield.currentState!.validate()) {
                      UserApi.updateUser(
                        context: context,
                        allergens: allergens,
                        height: double.parse(heightController.text),
                        weight: double.parse(weightController.text),
                        age: int.parse(ageController.text),
                        userId: UserApi.userId,
                      );
                    }
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.yellow,
                        borderRadius: BorderRadius.circular(10)),
                    child: const Center(
                        child: Text(
                      "Save",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

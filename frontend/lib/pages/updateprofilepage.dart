import 'package:flutter/material.dart';
import 'package:sri_cuisine/services/UserApi.dart';

class UpdateProfilePage extends StatefulWidget {
  const UpdateProfilePage({Key? key})
      : super(key: key); // Corrected the key parameter

  @override
  State<UpdateProfilePage> createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  final _formKey = GlobalKey<FormState>(); // Changed _formfield to _formKey

  @override
  void dispose() {
    heightController.dispose();
    weightController.dispose();
    ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.yellow,
        title: const Text("Update Profile"),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(
                width: 130,
                height: 130,
                child: ClipRect(
                  child: Image.asset('assets/images/profile.jpg'),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                UserApi.user.userName.toString(),
                style: const TextStyle(
                  fontFamily: 'inter',
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                  fontSize: 25,
                ),
              ),
              Text(
                UserApi.user.email.toString(),
                style: const TextStyle(
                  fontFamily: 'inter',
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 20),
              Form(
                key: _formKey, // Added key to Form widget
                child: Column(
                  children: [
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
                        bool heightValid =
                            RegExp(r'^\d{2,3}$').hasMatch(value!);

                        if (!heightValid) {
                          return "Enter Valid user Height (2-3 digits)";
                        } else {
                          return null;
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
                        bool weightValid =
                            RegExp(r'^\d{2,3}$').hasMatch(value!);

                        if (!weightValid) {
                          return "Enter Valid Weight (2-3 digits)";
                        } else {
                          return null;
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
                        if (!ageValid) {
                          return "Enter Valid Age (1-100)";
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          UserApi.updateUserDetails(
                            context: context,
                            height: double.parse(heightController.text),
                            weight: double.parse(weightController.text),
                            age: int.parse(ageController.text),
                          );
                        }
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.yellow,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(
                          child: Text(
                            "Save",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

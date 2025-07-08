import 'package:flutter/material.dart';
import 'package:sri_cuisine/services/AuthApi.dart';

class ResetPassPage extends StatefulWidget {
  @override
  State<ResetPassPage> createState() => _ResetPassPageState();
}

class _ResetPassPageState extends State<ResetPassPage> {
  final _formfield = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final newPassController = TextEditingController();
  bool passToggle = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text("ResetPassword"),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: Form(
                key: _formfield,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    
                    const SizedBox(height: 10),

                    // Username Validate part

                    TextFormField(
                        keyboardType: TextInputType.name,
                        controller: usernameController,
                        decoration: const InputDecoration(
                            labelText: "UserName",
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.person)),
                        validator: (value) {
                          bool userNameValid =
                              RegExp(r'^[a-z A-Z]+$').hasMatch(value!);

                          if (value.isEmpty) {
                            return "Enter userName";
                          } else if (!userNameValid) {
                            return "Enter Valid UserName";
                          }
                        }),

                    const SizedBox(
                      height: 20,
                    ),

                    // Password Validate part

                    TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      controller: newPassController,
                      obscureText: passToggle,
                      decoration: InputDecoration(
                        labelText: "New Password",
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.lock),
                        suffix: InkWell(
                          onTap: () {
                            setState(() {
                              passToggle = !passToggle;
                            });
                          },
                          child: Icon(passToggle
                              ? Icons.visibility
                              : Icons.visibility_off),
                        ),
                      ),
                     validator: (value) {
                        bool passwordValid = RegExp(
                                r'^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,}$')
                            .hasMatch(value!);

                        if (value.isEmpty) {
                          return "Enter New Password";
                        } else if (!passwordValid) {
                          return "Minimum 8 characters | one uppercase letter\none lowercase letter | one number";
                        }
                      },
                    ),

                    const SizedBox(height: 30),

                    InkWell(
                      onTap: () {
                        if (_formfield.currentState!.validate()) {
                          AuthApi.changePassword(
                              context, newPassController.text);
                        }
                      },

                      //button editing

                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colors.yellow,
                            borderRadius: BorderRadius.circular(10)),
                        child: const Center(
                            child: Text(
                          "Reset Password",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                      ),
                    ),

                    const SizedBox(
                      height: 25,
                    ),
                  ],
                )),
          ),
        ));
  }
}

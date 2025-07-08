import 'package:flutter/material.dart';
import 'package:sri_cuisine/pages/signup.dart';
import 'package:sri_cuisine/services/AuthApi.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formfield = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passController = TextEditingController();
  bool passToggle = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text("Log in"),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: Form(
                key: _formfield,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "images/whiteLogo.jpg",
                      height: 150,
                      width: 200,
                    ),
                    const SizedBox(height: 10),

                    // Username Validate part

                    TextFormField(
                        keyboardType: TextInputType.name,
                        controller: usernameController,
                        decoration: const InputDecoration(
                            labelText: "User Name",
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.person)),
                        validator: (value) {
                          bool userNameValid =
                              RegExp(r'^[a-z A-Z]+$').hasMatch(value!);

                          if (value.isEmpty) {
                            return "Enter User Name";
                          } else if (!userNameValid) {
                            return "Invalid user name";
                          }
                        }),

                    const SizedBox(
                      height: 20,
                    ),

                    // Password Validate part

                    TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      controller: passController,
                      obscureText: passToggle,
                      decoration: InputDecoration(
                        labelText: "Password",
                        border: const OutlineInputBorder(),
                        prefixIcon: const Icon(Icons.lock),
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
                          return "Enter Password";
                        } else if (!passwordValid) {
                          return "Incorrect Password";
                        }
                      },
                    ),

                    const SizedBox(height: 30),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            child: const Text(
                              'forgot password',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onTap: () {
                              if (usernameController.text.isNotEmpty) {
                                AuthApi.initiateChangePassword(
                                    context, usernameController.text);
                              } else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text("Enter your UserName"),
                                  duration: Duration(seconds: 2),
                                ));
                              }
                            },
                          )
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    InkWell(
                      onTap: () {
                        if (_formfield.currentState!.validate()) {
                          AuthApi.authenticate(context, usernameController.text,
                              passController.text);

                          // usernameController.clear();
                          // passController.clear();

                          // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext)=>MainScreen()));
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
                          "Log in",
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

                    //dont have an account text

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an account?"),
                        GestureDetector(
                          child: const Text(
                            "  Sign Up",
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          ),
                          onTap: () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (BuildContext) => SignupPage()));
                          },
                        )
                      ],
                    ),

                    const SizedBox(height: 5),
                  ],
                )),
          ),
        ));
  }
}

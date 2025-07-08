import 'package:flutter/material.dart';
import 'package:sri_cuisine/pages/login.dart';
import 'package:sri_cuisine/services/UserApi.dart';

class SignupPage extends StatefulWidget {
  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formfield = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  bool passToggle = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text("Sign up"),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 20,
              color: Colors.black,
            ),
          ),
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
                            return "Enter user name";
                          } else if (!userNameValid) {
                            return "Enter valid user name";
                          }
                        }),

                    const SizedBox(
                      height: 20,
                    ),

                    //email validation

                    TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                        decoration: const InputDecoration(
                          labelText: "Email Address",
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.email),
                        ),
                        validator: (value) {
                          bool emailValid = RegExp(
                                  r'^([a-zA-Z0-9_\.-]+)@([a-zA-Z0-9_\.-]+)\.([a-zA-Z]{2,6})$')
                              .hasMatch(value!);

                          if (value.isEmpty) {
                            return "Enter email address";
                          } else if (!emailValid) {
                            return "Enter valid email address!";
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
                          return "Minimum 8 characters | one uppercase letter\none lowercase letter | one number";
                        }
                      },
                    ),

                    const SizedBox(height: 30),

                    InkWell(
                      onTap: () async {
                        if (_formfield.currentState!.validate()) {
                          await UserApi.createUser(
                            context: context,
                            userName: usernameController.text.trim(),
                            email: emailController.text.trim(),
                            password: passController.text.trim(),
                          );
                        }
                      },
                      // Button UI remains unchanged
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.yellow,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(
                          child: Text(
                            "Sign up",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 25,
                    ),

                    //dont have an account text

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Already have an Account?"),
                        GestureDetector(
                          child: const Text(
                            " Log in",
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          ),
                          onTap: () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (BuildContext) => LoginPage()));
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

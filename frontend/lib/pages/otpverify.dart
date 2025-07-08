import 'package:flutter/material.dart';
import 'package:sri_cuisine/services/AuthApi.dart';

class OtpPage extends StatefulWidget {
  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final _formfield = GlobalKey<FormState>();
  final otpnumberController = TextEditingController();
  bool passToggle = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("O T P"),
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
                      Image.asset("images/lockimage.jpg",
                      height: 150,
                      width: 200,
                    ),
                    const SizedBox(height: 10),

                    // Username Validate part

                    TextFormField(
                        keyboardType: TextInputType.number,
                        controller: otpnumberController,
                        decoration: const InputDecoration(
                            labelText: "OTP",
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.lock)),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter recieved OtpNumber";
                          } else if (value!.length < 6) {
                            return "Enter Valid OtpNumber";
                          }
                        }),

                    const SizedBox(
                      height: 20,
                    ),

                    // Password Validate part

                    const SizedBox(height: 30),

                    InkWell(
                      onTap: () {
                        if (_formfield.currentState!.validate()) {
                          AuthApi.verifyOTP(context, int.parse(otpnumberController.text));
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
                          " Confirm",
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

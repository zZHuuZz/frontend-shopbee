import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:http/http.dart';

class SignUpPage extends StatefulWidget {
  @override
  State<SignUpPage> createState() => _SignUpState();
}

class _SignUpState extends State<SignUpPage> {
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final nameController = TextEditingController();
  final repassController = TextEditingController();

  bool termAndConditions = false;
  bool passToggle = true;

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.blue;
    }
    return Color(0xFF44E49E);
  }

  void _sleep() {
    // Sleep for 3 seconds
    Future.delayed(Duration(seconds: 10)).then((value) {
      // Perform any task after the sleep
      print('Sleep completed');
    });
  }

  void signup(String email, password, name, repass) async {
    if (name == "") {
      print('Please fill in the blank following the form of Full name !');
      return;
    }

    if (email == "") {
      print('Please fill in the blank following the form of Email !');
      return;
    }

    if (password == "") {
      print('Please fill your password in the blank !');
      return;
    }
    if (password != repass) {
      print('Your password is not matched!');
      return;
    } else {
      print(name);
      print(email);
      print(password);
    }

    Map<String, dynamic> requestBody = {
      'fullname': name,
      'email': email,
      'password': password,
      'sex': "M",
    };
    try {
      Response response = await post(
        Uri.parse('http://shopbee-api.shop:3000/v1/auth/sign-up'),
        body: jsonEncode(requestBody),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 201) {
        Map<String, dynamic> responseBody = jsonDecode(response.body);
        String data = responseBody['data'];
        print(data);
        print('Sign up successfully');
        _sleep();
        // ignore: use_build_context_synchronously
        Navigator.pushNamed(context, '/');
      } else {
        print('Sign up failed');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF33907C),
      body: Form(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 22, vertical: 20),
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 85),
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Welcome to ShopBee",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 29,
                  ),
                ),
              ),
              SizedBox(height: 54),
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Signup to your account",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(height: 40),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: Container(
                  height: 48,
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    controller: nameController,
                    style: TextStyle(color: Colors.white),
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                      labelText: "Full Name",
                      labelStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: Container(
                  height: 48,
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                    style: TextStyle(color: Colors.white),
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                      labelText: "Email",
                      labelStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: Container(
                  height: 48,
                  child: TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    controller: passController,
                    obscureText: passToggle,
                    style: TextStyle(color: Colors.white),
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                      labelText: "Password",
                      labelStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      suffix: InkWell(
                        onTap: () {
                          setState(() {
                            if (passToggle == true) {
                              passToggle = false;
                            } else {
                              passToggle = true;
                            }
                          });
                        },
                        child: Icon(
                          passToggle ? Icons.visibility : Icons.visibility_off,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: Container(
                  height: 48,
                  child: TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    controller: repassController,
                    obscureText: passToggle,
                    style: TextStyle(color: Colors.white),
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                      labelText: "Re-enter Password",
                      labelStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      suffix: InkWell(
                        onTap: () {
                          setState(() {
                            if (passToggle == true) {
                              passToggle = false;
                            } else {
                              passToggle = true;
                            }
                          });
                        },
                        child: Icon(
                          passToggle ? Icons.visibility : Icons.visibility_off,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 38),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: InkWell(
                  onTap: () {
                    signup(
                        emailController.text.toString(),
                        passController.text.toString(),
                        nameController.text.toString(),
                        repassController.text.toString());
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 48,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Center(
                      child: Text(
                        "Create",
                        style: TextStyle(
                          color: Color(0xFF13B58C),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Have an account?",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "/");
                    },
                    child: Text(
                      "Sign In",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

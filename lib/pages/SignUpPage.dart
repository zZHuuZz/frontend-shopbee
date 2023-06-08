import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:http/http.dart';

class SignUpPage extends StatefulWidget {
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final emailControler = TextEditingController();
  final passController = TextEditingController();
  final nameControler = TextEditingController();

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

  void signup(String email, password, name) async {
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
    } else {
      print(name);
      print(email);
      print(password);
    }

    Map<String, dynamic> requestBody = {
      'fullname': name,
      'email': email,
      'password': password,
    };
    try {
      Response response = await post(
        Uri.parse('http://4.194.216.57:3000/v1/sign-up'),
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
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFC0F4D0),
            Color(0xFFECFAB3),
          ],
        )),
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Image.asset(
                  "images/logo.png",
                  height: 300,
                  width: 300,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Welcome ! ",
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 40),
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: nameControler,
                  decoration: InputDecoration(
                    labelText: "Full name",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.account_circle),
                  ),
                ),
                SizedBox(height: 40),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: emailControler,
                  decoration: InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email),
                  ),
                ),
                SizedBox(height: 40),
                TextFormField(
                  keyboardType: TextInputType.visiblePassword,
                  controller: passController,
                  obscureText: passToggle,
                  decoration: InputDecoration(
                    labelText: "Password",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock),
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
                          passToggle ? Icons.visibility : Icons.visibility_off),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Checkbox(
                      checkColor: Colors.white,
                      fillColor: MaterialStateProperty.resolveWith(getColor),
                      value: termAndConditions,
                      onChanged: (bool? value) {
                        setState(() {
                          termAndConditions = value!;
                        });
                      },
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, "TermsAndConditionsPage");
                        },
                        child: Text(
                          "Agree with terms and conditions",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                InkWell(
                  onTap: () {
                    signup(
                        emailControler.text.toString(),
                        passController.text.toString(),
                        nameControler.text.toString());
                  },
                  child: Container(
                    height: 49,
                    width: 84,
                    decoration: BoxDecoration(
                      color: Color(0xFF44E49E),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
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
                      "Already have an account?",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "/");
                      },
                      child: Text(
                        "Log In",
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

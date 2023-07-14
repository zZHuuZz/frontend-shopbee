import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginState();
}

class _LoginState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passController = TextEditingController();
  bool passToggle = true;

  void signin(String email, password) async {
    if (email == "") {
      print('Email cannot empty !');
      Navigator.pushNamed(context, 'ForgotPasswordPage');
    } else {
      if (password == "") {
        print('password cannot empty !');
        Navigator.pushNamed(context, 'ForgotPasswordPage');
      }
    }
    Map<String, dynamic> requestBody = {
      'email': email,
      'password': password,
    };

    try {
      Response response = await post(
        Uri.parse('http://shopbee-api.shop:3000/v1/auth/sign-in'),
        body: jsonEncode(requestBody),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        Map<String, dynamic> responseBody = jsonDecode(response.body);
        String data = responseBody['data']['fullname'];
        print(data);
        print('Sign in successfully');
        Navigator.pushNamed(context, 'HomePage');
      } else {
        print('Sign in failed');
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
              SizedBox(height: 150),
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
              SizedBox(height: 66),
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Login to your account",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(height: 50),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: Container(
                  height: 48,
                  child: TextFormField(
                    autofocus: false,
                    keyboardType: TextInputType.text,
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
                    autofocus: false,
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
              SizedBox(height: 38),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: InkWell(
                  onTap: () {
                    signin(emailController.text.toString(),
                        passController.text.toString());
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
                        "Log in",
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
              SizedBox(height: 30),
              Align(
                alignment: Alignment.center,
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "ForgotPasswordPage");
                  },
                  child: Text(
                    "Forgot your password?",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "SignUpPage");
                    },
                    child: Text(
                      "Sign Up",
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

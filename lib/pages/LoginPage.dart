import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailControler = TextEditingController();
  final passController = TextEditingController();
  bool passToggle = true;

  void signin(String email, password) async{
    if(email == "") {
      print('Email cannot empty !');
      Navigator.pushNamed(context, 'ForgotPasswordPage');
    }
    else {
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
        Uri.parse('http://4.194.216.57:3000/v1/sign-in'),
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
        Navigator.pushNamed(context, 'MainPage');
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
                    "Welcome back,",
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 50),
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: emailControler,
                  decoration: InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.account_circle),
                  ),
                ),
                SizedBox(height: 50),
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
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "ForgotPasswordPage");
                      },
                      child: Text(
                        "Forgot password?",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                SizedBox(height: 50),
                InkWell(
                  onTap: () {
                    signin(emailControler.text.toString(), passController.text.toString());
                    //Main page
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
                        "Log in",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
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
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "SignUpPage");
                      },
                      child: Text(
                        "Sign Up",
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

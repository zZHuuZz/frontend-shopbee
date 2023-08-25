// ignore_for_file: file_names, sized_box_for_whitespace, avoid_print

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shopbee/globals.dart';
import 'package:http/http.dart';

extension extString on String {
  bool get isValidPassword {
    final passwordRegExp =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    return !passwordRegExp.hasMatch(this);
  }
}

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  String? jwtToken;
  final _formKey = GlobalKey<FormState>();

  final oldpassController = TextEditingController();
  final passController = TextEditingController();
  final repassController = TextEditingController();

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
    return const Color(0xFF44E49E);
  }

  void changepassword(String oldpass, password) async {
    Map<String, dynamic> requestBody = {
      'old_pass': oldpass,
      'new_pass': password,
    };
    try {
      final response = await post(
        Uri.parse(apiURL + 'api/v1/user/changepw'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $jwtToken',
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> responseBody = jsonDecode(response.body);
        print(responseBody['data']);
        print('Change password successfully');
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Success"),
            content: const Text("Password have been changed"),
            actions: [
              TextButton(
                child: const Text("OK"),
                onPressed: () {
                  Navigator.popUntil(
                      context, ModalRoute.withName('ProfilePage'));
                },
              ),
            ],
          ),
        );
      } else {
        print('Change password failed');
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Failded"),
            content: const Text("Change password failed"),
            actions: [
              TextButton(
                child: const Text("OK"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      }
    } catch (e) {
      print(e.toString());
    }
  }

  // Function to set the JWT token
  Future<void> _setToken(String token) async {
    await setToken(token);
    setState(() {
      jwtToken = token;
    });
    print(jwtToken.toString());
  }

  // Function to get the JWT token
  Future<void> _getToken() async {
    String? token = await getToken();
    setState(() {
      jwtToken = token;
    });
  }

  @override
  void initState() {
    _getToken().then((value) {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE5E5E5),
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Color(0xFF33907C),
        title: Text(
          'Change Password',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            size: 40,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              const SizedBox(height: 86),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: oldpassController,
                  style: const TextStyle(color: Color(0xFF33907C)),
                  cursorColor: Color(0xFF33907C),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 10.0),
                    labelText: "Old Password",
                    labelStyle: const TextStyle(
                      color: Color(0xFF33907C),
                      fontSize: 18,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xFF33907C)),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xFF33907C)),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xFF33907C)),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xFF33907C)),
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 35),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
                child: TextFormField(
                  keyboardType: TextInputType.visiblePassword,
                  controller: passController,
                  obscureText: passToggle,
                  style: const TextStyle(color: Color(0xFF33907C)),
                  cursorColor: Color(0xFF33907C),
                  validator: (val) {
                    if (val!.isValidPassword) return 'Enter valid password';
                    if (val.isEmpty) return 'Please enter password';
                    return null;
                  },
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 10.0),
                    labelText: "New Password",
                    labelStyle: const TextStyle(
                      color: Color(0xFF33907C),
                      fontSize: 18,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xFF33907C)),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xFF33907C)),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xFF33907C)),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xFF33907C)),
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
                        color: Color(0xFF33907C),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 35),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
                child: TextFormField(
                  keyboardType: TextInputType.visiblePassword,
                  controller: repassController,
                  obscureText: passToggle,
                  style: const TextStyle(color: Color(0xFF33907C)),
                  cursorColor: Color(0xFF33907C),
                  validator: (value) {
                    if (repassController.text.toString() !=
                        passController.text.toString()) {
                      return 'Your password does not match';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 10.0),
                    labelText: "Re-enter New Password",
                    labelStyle: const TextStyle(
                      color: Color(0xFF33907C),
                      fontSize: 18,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xFF33907C)),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xFF33907C)),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xFF33907C)),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xFF33907C)),
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
                        color: Color(0xFF33907C),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 55),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: InkWell(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      changepassword(
                          oldpassController.text, passController.text);
                    }
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 48,
                    decoration: BoxDecoration(
                      color: Color(0xFF33907C),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: const Center(
                      child: Text(
                        "Change",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

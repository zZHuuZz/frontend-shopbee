import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPasswordPage> {
  final codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final String verificationContent = '''
    We’ve sent a verification code to your email. Please check it out and fill the code you revieced to the box below: 
    ''';
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xFFC0F4D0),
            const Color(0xFFECFAB3),
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
                const SizedBox(height: 50),
                Text(
                  textAlign: TextAlign.center,
                  verificationContent,
                  style: TextStyle(fontSize: 23.0),
                ),
                SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 15),
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                      ),
                      child: Row(
                        children: [
                          Container(
                              margin: EdgeInsets.only(left: 5),
                              height: 51,
                              width: 206,
                              child: TextFormField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                ),
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 50),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, "/");
                  },
                  child: Container(
                    height: 49,
                    width: 98,
                    decoration: BoxDecoration(
                      color: Color(0xFF44E49E),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                      child: Text(
                        "Confirm",
                        style: TextStyle(
                          color: Colors.white,
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
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class EmailVerificationPage extends StatefulWidget {
  @override
  State<EmailVerificationPage> createState() => _EmailVerificationState();
}

class _EmailVerificationState extends State<EmailVerificationPage> {
  final pinController = TextEditingController();
  String currentText = "";

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
                  "Email Verification",
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
                  "Enter your OTP code here",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
              SizedBox(height: 68),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 47),
                  child: PinCodeTextField(
                    appContext: context,
                    pastedTextStyle: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    length: 6,
                    blinkWhenObscuring: true,
                    animationType: AnimationType.fade,
                    validator: (v) {
                      if (v!.length < 6) {
                        return "Please fill";
                      } else {
                        return null;
                      }
                    },
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.underline,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 60,
                      fieldWidth: 36,
                      activeFillColor: Colors.transparent,
                      disabledColor: Colors.white,
                      selectedColor: Colors.white,
                      inactiveFillColor: Colors.transparent,
                      selectedFillColor: Colors.transparent,
                      activeColor: Colors.white,
                      inactiveColor: Colors.white,
                    ),
                    cursorColor: Colors.white,
                    animationDuration: const Duration(milliseconds: 300),
                    enableActiveFill: true,
                    controller: pinController,
                    keyboardType: TextInputType.number,
                    onCompleted: (v) {
                      debugPrint("Completed");
                    },
                    // onTap: () {
                    //   print("Pressed");
                    // },
                    onChanged: (value) {
                      debugPrint(value);
                      setState(() {
                        currentText = value;
                      });
                    },
                  )),
              SizedBox(height: 65),
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Didn't you received any code?",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
              SizedBox(height: 8),
              Align(
                alignment: Alignment.center,
                child: InkWell(
                  onTap: () {
                    //add reset code function here
                  },
                  child: Text(
                    "Reset new code",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 57),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: InkWell(
                  onTap: () {},
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 48,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Center(
                      child: Text(
                        "Verify",
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
            ],
          ),
        ),
      ),
    );
  }
}

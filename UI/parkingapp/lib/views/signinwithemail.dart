// Declare the object
import 'package:email_auth/email_auth.dart';
import 'package:flutter/material.dart';
import 'package:parkingapp/services/auth_service.dart';
import 'package:parkingapp/widgets/hoverbutton.dart';

class SignInWemail extends StatefulWidget {
  const SignInWemail({Key? key}) : super(key: key);

  @override
  _SignInWemailState createState() => _SignInWemailState();
}

class _SignInWemailState extends State<SignInWemail> {
  // Declare the object
  late EmailAuth emailAuth;
  bool submitValid = false;
  bool verified = false;
  @override
  void initState() {
    super.initState();
    // Initialize the package
    emailAuth = new EmailAuth(
      sessionName: "SmartParking",
    );

    /// Configuring the remote server
  }

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  /// a Boolean function to verify if the Data provided is true
  bool verify() {
    setState(() {
      verified = emailAuth.validateOtp(
          recipientMail: _emailController.value.text,
          userOtp: _otpController.value.text);
    });
    return verified;
  }

  /// a void funtion to send the OTP to the user
  /// Can also be converted into a Boolean function and render accordingly for providers
  void sendOtp() async {
    bool result = await emailAuth.sendOtp(
        recipientMail: _emailController.value.text, otpLength: 5);
    if (result) {
      setState(() {
        submitValid = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 500,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                  margin:
                      const EdgeInsets.only(bottom: 15, right: 15, left: 15),
                  child: TextField(
                    controller: _emailController,
                    autofocus: false,
                    style: const TextStyle(fontSize: 15.0, color: Colors.black),
                    decoration: InputDecoration(
                      suffix: TextButton(
                          onPressed: () {
                            sendOtp();
                          },
                          child: Text("send OTP")),
                      border: InputBorder.none,
                      hintText: 'Please enter email',
                      filled: true,
                      fillColor: Colors.grey.shade200,
                      focusColor: Colors.red,
                      contentPadding: const EdgeInsets.only(
                          left: 14.0, bottom: 6.0, top: 8.0),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff2FC4B2)),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade200),
                      ),
                    ),
                  )),
              Container(
                  margin:
                      const EdgeInsets.only(bottom: 15, right: 15, left: 15),
                  child: TextField(
                    controller: _otpController,
                    autofocus: false,
                    style: const TextStyle(fontSize: 15.0, color: Colors.black),
                    decoration: InputDecoration(
                      suffix: IgnorePointer(
                        ignoring: !(submitValid),
                        child: TextButton(
                            onPressed: () {
                              verify();
                            },
                            child: Text("verify OTP")),
                      ),
                      border: InputBorder.none,
                      hintText: 'Please enter OTP',
                      filled: true,
                      fillColor: Colors.grey.shade200,
                      focusColor: Colors.red,
                      contentPadding: const EdgeInsets.only(
                          left: 14.0, bottom: 6.0, top: 8.0),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff2FC4B2)),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade200),
                      ),
                    ),
                  )),
              Container(
                  margin:
                      const EdgeInsets.only(bottom: 15, right: 15, left: 15),
                  child: IgnorePointer(
                    ignoring: !(verified),
                    child: TextField(
                      controller: _passwordController,
                      autofocus: false,
                      style:
                          const TextStyle(fontSize: 15.0, color: Colors.black),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Please enter password',
                        filled: true,
                        fillColor: Colors.grey.shade200,
                        focusColor: Colors.red,
                        contentPadding: const EdgeInsets.only(
                            left: 14.0, bottom: 6.0, top: 8.0),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff2FC4B2)),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade200),
                        ),
                      ),
                    ),
                  )),
              IgnorePointer(
                ignoring: !(verified),
                child: SizedBox(
                    width: double.infinity,
                    height: 80,
                    child: Container(
                        margin: EdgeInsets.all(15), // <-- match_parent
                        child: OnHoverButton(builder: (isHovered) {
                          final boxcolor = isHovered
                              ? const Color(0xff2FC4B2)
                              : Colors.black;
                          return ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(boxcolor),
                            ),
                            onPressed: () async {
                              await AuthService().signUp(_emailController.text,
                                  _passwordController.text);
                              Navigator.pop(context);
                            },
                            child: const Text(
                              "SIGN UP",
                              style: TextStyle(color: Colors.white),
                            ),
                          );
                        }))),
              )
            ],
          ),
        ),
      ),
    );
  }
}

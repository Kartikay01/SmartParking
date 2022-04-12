import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parkingapp/services/auth_service.dart';
import 'package:parkingapp/views/signinwithemail.dart';
import 'package:parkingapp/views/workersignin.dart';
import 'package:parkingapp/widgets/hoverbutton.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final Color googleColor = const Color(0xffDF4A32);
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();
  String email = " ";
  Future _getcreds() async {
    Uri url = Uri.parse("http://localhost:8080/getCreds");
    final response =
        await http.get(url, headers: {'username': usernameController.text});
    setState(() {
      email = response.body.toString().trim();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Sign In to ParkSmart",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25.0,
                  fontWeight: FontWeight.w900,
                )),
            SizedBox(height: 15),
            Container(
                width: 300,
                margin: const EdgeInsets.only(bottom: 15, right: 15, left: 15),
                child: TextField(
                  controller: usernameController,
                  autofocus: false,
                  style: const TextStyle(fontSize: 15.0, color: Colors.black),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'username',
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
                width: 300,
                margin: const EdgeInsets.only(bottom: 15, right: 15, left: 15),
                child: TextField(
                  controller: passwordController,
                  autofocus: false,
                  style: const TextStyle(fontSize: 15.0, color: Colors.black),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'password',
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
            SizedBox(
                width: 250,
                height: 64,
                child: Container(
                    color: Colors.white,
                    margin: EdgeInsets.all(7), // <-- match_parent
                    child: OnHoverButton(builder: (isHovered) {
                      final color = isHovered ? googleColor : Colors.black;
                      return ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(color),
                          ),
                          onPressed: () async {
                            _getcreds();
                            AuthService().login(email, passwordController.text);
                          },
                          child: const Text("LOG IN"));
                    }))),
            SizedBox(
              height: 15,
              child: Text("- OR -"),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    width: 120,
                    height: 64,
                    child: Container(
                        color: Colors.white,
                        margin: EdgeInsets.all(7), // <-- match_parent
                        child: OnHoverButton(builder: (isHovered) {
                          final color = isHovered ? googleColor : Colors.black;
                          return ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(color),
                              ),
                              onPressed: () async {
                                AuthService().signInWithGoogle();
                              },
                              child: const Icon(FontAwesomeIcons.google));
                        }))),
                SizedBox(
                    width: 120,
                    height: 64,
                    child: Container(
                        color: Colors.white,
                        margin: EdgeInsets.all(7), // <-- match_parent
                        child: OnHoverButton(builder: (isHovered) {
                          final color = isHovered ? googleColor : Colors.black;
                          return ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(color),
                              ),
                              onPressed: () async {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SignInWemail()));
                              },
                              child: const Icon(CupertinoIcons.mail));
                        }))),
              ],
            ),
            SizedBox(height: 100),
            TextButton(
                onPressed: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => WorkerDashboard()));
                },
                child: Text("workers' portal"))
          ],
        ),
      ),
    );
  }
}

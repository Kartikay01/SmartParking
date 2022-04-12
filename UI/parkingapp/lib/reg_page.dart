// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:dio/dio.dart';
import 'package:email_auth/email_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:parkingapp/services/auth_service.dart';
import 'package:parkingapp/views/verify.dart';

class RegPage extends StatefulWidget {
  const RegPage({Key? key}) : super(key: key);

  @override
  _RegPageState createState() => _RegPageState();
}

class _RegPageState extends State<RegPage> {
  final _apiPost = Uri.parse('http://172.16.142.47:8080/createUser');
  var otpController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  bool loginbutton = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
            color: const Color(0xff2FC4B2),
            child: Column(children: [
              AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: const Color(0xff2FC4B2),
                centerTitle: true,
                title: const Text(
                  "Smart Parking",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Expanded(
                flex: 4,
                child: Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(10),
                  child: Column(children: <Widget>[
                    Container(
                      margin: const EdgeInsets.all(10),
                      alignment: Alignment.centerLeft,
                      child: const Text("username",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15.0,
                            fontWeight: FontWeight.w600,
                          )),
                    ),
                    Container(
                      margin: const EdgeInsets.all(10),
                      alignment: Alignment.centerLeft,
                      child: const Text("email",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15.0,
                            fontWeight: FontWeight.w600,
                          )),
                    ),
                    Container(
                        margin: const EdgeInsets.only(bottom: 30),
                        child: TextField(
                          controller: emailController,
                          autofocus: false,
                          style: const TextStyle(
                              fontSize: 15.0, color: Colors.black),
                          decoration: InputDecoration(
                            suffixIcon: TextButton(
                              child: Text("send OTP"),
                              onPressed: () {},
                            ),
                            border: InputBorder.none,
                            hintText: 'Please enter your email',
                            filled: true,
                            fillColor: Colors.grey.shade200,
                            focusColor: Colors.red,
                            contentPadding: const EdgeInsets.only(
                                left: 14.0, bottom: 6.0, top: 8.0),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xff2FC4B2)),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey.shade200),
                            ),
                          ),
                        )),
                    Container(
                      margin: EdgeInsets.all(10),
                      alignment: Alignment.centerLeft,
                      child: const Text("Password",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15.0,
                            fontWeight: FontWeight.w600,
                          )),
                    ),
                    Container(
                        margin: EdgeInsets.only(bottom: 30),
                        child: TextField(
                          controller: passwordController,
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,
                          autofocus: false,
                          style: TextStyle(fontSize: 15.0, color: Colors.black),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Please enter your password',
                            filled: true,
                            fillColor: Colors.grey.shade200,
                            focusColor: Colors.red,
                            contentPadding: const EdgeInsets.only(
                                left: 14.0, bottom: 6.0, top: 8.0),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xff2FC4B2)),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey.shade200),
                            ),
                          ),
                        )),
                    Container(
                        margin: const EdgeInsets.only(bottom: 30),
                        child: TextField(
                          controller: otpController,
                          autofocus: false,
                          style: const TextStyle(
                              fontSize: 15.0, color: Colors.black),
                          decoration: InputDecoration(
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
                              borderSide:
                                  BorderSide(color: Colors.grey.shade200),
                            ),
                          ),
                        )),
                    Expanded(
                        flex: 1,
                        child: Container(
                          color: Colors.white,
                          child: Column(
                            children: [
                              SizedBox(
                                  width: double.infinity,
                                  height: 80,
                                  child: Container(
                                      color: Colors.white,
                                      margin: EdgeInsets.all(
                                          15), // <-- match_parent
                                      child: ElevatedButton(
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Color(0xff2FC4B2)),
                                        ),
                                        onPressed: loginbutton
                                            ? () async {
                                                AuthService()
                                                    .signInWithGoogle();
                                                /*var dio = Dio();
                                          var response = await dio.post(
                                              'http://localhost:8080/createUser',
                                              data: {
                                                "uid": usernameController
                                                    .text, //FirebaseAuth
                                                //.instance.currentUser!.uid,
                                                "email": emailController.text,
                                                "password":
                                                    passwordController.text,
                                              });
                                          print(
                                              'Response status: ${response.statusCode}');
                                          print(
                                              'Response body: ${response.data}');*/
                                              }
                                            : null,
                                        child: Text(
                                          "REGISTER",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ))),
                            ],
                          ),
                        ))
                  ]),
                ),
              )
            ])));
  }
}

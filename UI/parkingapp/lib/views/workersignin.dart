import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:parkingapp/models/worker.dart';
import 'package:parkingapp/widgets/hoverbutton.dart';
import 'package:http/http.dart' as http;

class WorkerDashboard extends StatefulWidget {
  const WorkerDashboard({Key? key}) : super(key: key);

  @override
  _WorkerDashboardState createState() => _WorkerDashboardState();
}

class _WorkerDashboardState extends State<WorkerDashboard> {
  final Color googleColor = const Color(0xffDF4A32);
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();
  late Worker w;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
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
                contentPadding:
                    const EdgeInsets.only(left: 14.0, bottom: 6.0, top: 8.0),
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
                contentPadding:
                    const EdgeInsets.only(left: 14.0, bottom: 6.0, top: 8.0),
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
                        _getworkerdetails(
                            usernameController.text, passwordController.text);
                      },
                      child: const Text("LOG IN"));
                }))),
      ],
    ));
  }

  _getworkerdetails(String username, String password) async {
    Uri url = Uri.parse("http://localhost:8080/getWorkerDetails");
    final response =
        await http.get(url, headers: {'workername': usernameController.text});
    setState(() {
      w = Worker.fromJson(json.decode(response.body));
    });
  }
}

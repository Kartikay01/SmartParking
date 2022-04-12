import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:parkingapp/models/user.dart' as user;
import 'package:http/http.dart' as http;
import 'package:parkingapp/widgets/hoverbutton.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Map<String, dynamic> map = Map();
  Future _getUserDetails() async {
    Uri url = Uri.parse("http://localhost:8080/getUserDetails");
    final response = await http.get(url, headers: {
      'uid': FirebaseAuth.instance.currentUser!.uid,
    });
    setState(() {
      map = json.decode(response.body);
    });
  }

  @override
  void initState() {
    super.initState();
    _getUserDetails();
  }

  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("username:",
                    style: TextStyle(
                        color: Color(0xff2FC4B2),
                        fontWeight: FontWeight.w800,
                        fontSize: 20)),
                Text("name:",
                    style: TextStyle(
                        color: Color(0xff2FC4B2),
                        fontWeight: FontWeight.w800,
                        fontSize: 20)),
                Text("email:",
                    style: TextStyle(
                        color: Color(0xff2FC4B2),
                        fontWeight: FontWeight.w800,
                        fontSize: 20)),
                Text("Phone Number:",
                    style: TextStyle(
                        color: Color(0xff2FC4B2),
                        fontWeight: FontWeight.w800,
                        fontSize: 20)),
                Text("Car Registration Number:",
                    style: TextStyle(
                        color: Color(0xff2FC4B2),
                        fontWeight: FontWeight.w800,
                        fontSize: 20)),
                Text("Address",
                    style: TextStyle(
                        color: Color(0xff2FC4B2),
                        fontWeight: FontWeight.w800,
                        fontSize: 20)),
                Text("Wallet: Rs",
                    style: TextStyle(
                        color: Color(0xff2FC4B2),
                        fontWeight: FontWeight.w800,
                        fontSize: 20)),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(map['username'], style: TextStyle(fontSize: 20)),
                Text("${map['firstname']} ${map['lastname']}",
                    style: TextStyle(fontSize: 20)),
                Text(map['email'], style: TextStyle(fontSize: 20)),
                Text(map['phoneNumber'], style: TextStyle(fontSize: 20)),
                Text(map['carnumber'], style: TextStyle(fontSize: 20)),
                Text(map['address'], style: TextStyle(fontSize: 20)),
                Text(map['wallet'].toString(), style: TextStyle(fontSize: 20)),
              ],
            ),
          ],
        ),
        width: 500,
      ),
    );
  }
}

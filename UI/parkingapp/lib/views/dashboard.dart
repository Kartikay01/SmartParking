import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:parkingapp/services/auth_service.dart';
import 'package:parkingapp/admindash/admindashboard.dart';
import 'package:parkingapp/views/bookings.dart';
import 'package:parkingapp/views/profile.dart';
import 'package:parkingapp/views/search.dart';
import 'package:parkingapp/views/userdashboard.dart';
import 'package:parkingapp/views/userdetails.dart';
import 'package:parkingapp/widgets/hoverbutton.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final Color googleColor = const Color(0xffDF4A32);

  bool checkuserdeet = true;
  int checkusertype = 0;

  @override
  void initState() {
    super.initState();
    _checkUserDetails();
    if (checkuserdeet) {
      checkUserType();
    }
  }

  Widget build(BuildContext context) {
    if (!checkuserdeet) {
      return UserDetails();
    } else {
      if (checkusertype == 0) {
        return UserDashboard();
      } else {
        return AdminDashboard();
      }
    }
  }

  Future _checkUserDetails() async {
    Uri url = Uri.parse("http://localhost:8080/checkUserDetails");
    final response = await http.get(url, headers: {
      'uid': FirebaseAuth.instance.currentUser!.uid,
    });
    setState(() {
      checkuserdeet = json.decode(response.body);
    });
  }

  Future checkUserType() async {
    Uri url = Uri.parse("http://localhost:8080/getUserDetails");
    final response = await http.get(url, headers: {
      'uid': FirebaseAuth.instance.currentUser!.uid,
    });
    Map<String, dynamic> map = Map();
    map = json.decode(response.body);
    setState(() {
      print(map['type']);
      checkusertype = map['type'];
    });
  }
}

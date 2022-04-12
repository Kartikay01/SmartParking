import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:parkingapp/services/auth_service.dart';
import 'package:parkingapp/admindash/adminparkinglot.dart';
import 'package:parkingapp/views/bookings.dart';
import 'package:parkingapp/views/profile.dart';
import 'package:parkingapp/views/search.dart';
import 'package:parkingapp/views/userdetails.dart';
import 'package:parkingapp/admindash/workerspage.dart';
import 'package:parkingapp/widgets/hoverbutton.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({Key? key}) : super(key: key);

  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  final Color googleColor = const Color(0xffDF4A32);

  int _currentIndex = 1;
  bool checkuserdeet = true;
  var currentTab = [Workerspage(), AdminParkingLot(), const BookingsPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              Container(
                width: double.infinity,
                alignment: Alignment.topRight,
                child: SizedBox(
                    width: 150,
                    height: 80,
                    child: Container(
                      color: Colors.white,
                      margin: EdgeInsets.all(15), // <-- match_parent
                      child: OnHoverButton(builder: (isHovered) {
                        final color = isHovered ? googleColor : Colors.black;
                        return ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.transparent),
                                shadowColor: MaterialStateProperty.all(
                                    Colors.transparent)),
                            onPressed: () async {
                              Navigator.of(context).pop();
                              AuthService().signOut();
                            },
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.logout,
                                    color: color,
                                  ),
                                  Text(
                                    "log out",
                                    style: TextStyle(color: color),
                                  ),
                                ]));
                      }),
                    )),
              ),
              currentTab[_currentIndex]
            ],
          ),
        ),
        bottomNavigationBar: Container(
          height: 100,
          decoration: const BoxDecoration(
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.transparent,
                blurRadius: 10,
              ),
            ],
          ),
          child: BottomNavigationBar(
            elevation: 0,
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            unselectedItemColor: Colors.black,
            selectedItemColor: googleColor,
            backgroundColor: Colors.white,
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  FontAwesomeIcons.user,
                ),
                label: 'profile',
              ),
              BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.parking),
                label: 'parking lots',
              ),
              BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.history),
                label: 'bookings',
              ),
            ],
          ),
        ));
  }
}

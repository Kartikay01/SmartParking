// ignore_for_file: prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:parkingapp/services/auth_service.dart';
import 'package:parkingapp/views/dashboard.dart';
import 'package:parkingapp/views/parkinglotpage.dart';
import 'package:parkingapp/views/search.dart';

import 'reg_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: routes,
        home: AuthService().handleAuth());
  }
}

Route routes(RouteSettings settings) {
  if (settings.name == '/SearchPage') {
    return MaterialPageRoute(
      builder: (context) {
        return Dashboard();
      },
    );
  } else {
    return MaterialPageRoute(
      builder: (context) {
        return Dashboard();
      },
    );
  }
}

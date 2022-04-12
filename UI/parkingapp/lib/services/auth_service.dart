import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:parkingapp/reg_page.dart';
import 'package:parkingapp/admindash/admindashboard.dart';
import 'package:parkingapp/views/dashboard.dart';
import 'package:parkingapp/views/search.dart';
import 'package:parkingapp/views/signin.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:parkingapp/views/userdetails.dart';

class AuthService {
  //Handle Authentication
  handleAuth() {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (true) {
            return const Dashboard();
          } else {
            return AdminDashboard();
          }
        } else {
          return const SignInPage();
        }
      },
    );
  }

  //Sign Out
  signOut() {
    FirebaseAuth.instance.signOut();
  }

  //Sign in
  signUp(email, password) async {
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((user) {
      print('Signed in');
    }).catchError((e) {
      print(e);
    });
  }

  login(email, password) async {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((user) {
      print('Signed in');
    }).catchError((e) {
      print(e);
    });
  }

  signInWithGoogle() async {
    final googleUser = await GoogleSignIn.standard().signIn();
    final googleAuth = await googleUser!.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final authResult =
        await FirebaseAuth.instance.signInWithCredential(credential);
  }
}

/*class Type {
  int type = 0;
  checkUserType() async {
    Uri url = Uri.parse("http://localhost:8080/getUserDetails");
    final response = await http.get(url, headers: {
      'uid': FirebaseAuth.instance.currentUser!.uid,
    });
    Map<String, dynamic> map = Map();
    map = json.decode(response.body);
    type = map['type'];
  }
}*/

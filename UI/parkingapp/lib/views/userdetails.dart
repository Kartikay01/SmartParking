import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:parkingapp/views/dashboard.dart';
import 'package:parkingapp/widgets/hoverbutton.dart';

class UserDetails extends StatefulWidget {
  UserDetails({Key? key}) : super(key: key);

  @override
  _UserDetailsState createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  var firstnamecontroller = TextEditingController();
  var lastnamecontroller = TextEditingController();
  var phonenumbercontroller = TextEditingController();
  var emailcontroller = TextEditingController();
  var addresscontroller = TextEditingController();
  var carnumbercontroller = TextEditingController();
  var usernamecontroller = TextEditingController();
  Future createuser() async {
    DateTime ts = DateTime.now();
    int tsint = ts.millisecondsSinceEpoch;
    var dio = Dio();
    var response = await dio.post('http://localhost:8080/createUser',
        data: {
          "username": usernamecontroller.text,
          "firstname": firstnamecontroller.text,
          "lastname": lastnamecontroller.text,
          "address": addresscontroller.text,
          "carnumber": carnumbercontroller.text,
          "type": 0,
          "phoneNumber": phonenumbercontroller.text,
          "email": FirebaseAuth.instance.currentUser!.email
        },
        options: Options(
            headers: {"docID": FirebaseAuth.instance.currentUser!.uid}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Container(
        margin: EdgeInsets.all(50),
        width: 500,
        child: Column(
          children: [
            Container(
                margin: const EdgeInsets.only(bottom: 15, right: 15, left: 15),
                child: TextField(
                  controller: usernamecontroller,
                  autofocus: false,
                  style: const TextStyle(fontSize: 15.0, color: Colors.black),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Please enter username',
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
                margin: const EdgeInsets.only(bottom: 15, right: 15, left: 15),
                child: TextField(
                  controller: firstnamecontroller,
                  autofocus: false,
                  style: const TextStyle(fontSize: 15.0, color: Colors.black),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Please enter firstname',
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
                margin: const EdgeInsets.only(bottom: 15, right: 15, left: 15),
                child: TextField(
                  controller: lastnamecontroller,
                  autofocus: false,
                  style: const TextStyle(fontSize: 15.0, color: Colors.black),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Please enter lastname',
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
                margin: const EdgeInsets.only(bottom: 15, right: 15, left: 15),
                child: TextField(
                  controller: phonenumbercontroller,
                  autofocus: false,
                  style: const TextStyle(fontSize: 15.0, color: Colors.black),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Phone number',
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
                margin: const EdgeInsets.only(bottom: 15, right: 15, left: 15),
                child: TextField(
                  controller: addresscontroller,
                  autofocus: false,
                  style: const TextStyle(fontSize: 15.0, color: Colors.black),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'address',
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
                margin: const EdgeInsets.only(bottom: 15, right: 15, left: 15),
                child: TextField(
                  controller: carnumbercontroller,
                  autofocus: false,
                  style: const TextStyle(fontSize: 15.0, color: Colors.black),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'car registration number',
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
                width: double.infinity,
                height: 80,
                child: Container(
                    margin: EdgeInsets.all(15), // <-- match_parent
                    child: OnHoverButton(builder: (isHovered) {
                      final boxcolor =
                          isHovered ? const Color(0xff2FC4B2) : Colors.black;

                      return ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(boxcolor),
                        ),
                        onPressed: () async {
                          await createuser();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Dashboard(),
                              ));
                        },
                        child: const Text(
                          "SAVE DETAILS",
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    }))),
          ],
        ),
      ),
    ));
  }
}

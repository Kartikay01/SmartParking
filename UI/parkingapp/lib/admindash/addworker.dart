import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:parkingapp/widgets/hoverbutton.dart';

class AddWorker extends StatefulWidget {
  const AddWorker({Key? key}) : super(key: key);

  @override
  _AddWorkerState createState() => _AddWorkerState();
}

class _AddWorkerState extends State<AddWorker> {
  var locationcontroller = TextEditingController();
  var pricecontroller = TextEditingController();
  var namecontroller = TextEditingController();
  var passwordcontroller = TextEditingController();
  var usernamecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            margin: const EdgeInsets.only(bottom: 15, right: 15, left: 15),
            child: TextField(
              controller: locationcontroller,
              autofocus: false,
              style: const TextStyle(fontSize: 15.0, color: Colors.black),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'location',
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
            margin: const EdgeInsets.only(bottom: 15, right: 15, left: 15),
            child: TextField(
              controller: namecontroller,
              autofocus: false,
              style: const TextStyle(fontSize: 15.0, color: Colors.black),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'workername',
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
            margin: const EdgeInsets.only(bottom: 15, right: 15, left: 15),
            child: TextField(
              controller: usernamecontroller,
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
            margin: const EdgeInsets.only(bottom: 15, right: 15, left: 15),
            child: TextField(
              controller: passwordcontroller,
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
                      await addw();
                      _showDialog();
                    },
                    child: const Text(
                      "ADD WORKER",
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                }))),
      ],
    );
  }

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("!!"),
          content: new Text(
              "worker ${namecontroller.text} assigned at ${locationcontroller.text} \n alotted ID No.: ${usernamecontroller.text}"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {});
              },
            ),
          ],
        );
      },
    );
  }

  Future addw() async {
    DateTime ts = DateTime.now();
    int tsint = ts.millisecondsSinceEpoch;
    var dio = Dio();
    var response = await dio.post('http://localhost:8080/createWorker', data: {
      "location": locationcontroller.text,
      "workername": namecontroller.text,
      "username": usernamecontroller.text,
      "passwordString": passwordcontroller.text,
      "dateofjoining": tsint,
    });
    return response.data;
  }
}

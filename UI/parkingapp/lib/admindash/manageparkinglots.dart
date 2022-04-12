import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:parkingapp/models/parkinglot.dart';
import 'package:parkingapp/models/parkinglotlistdata.dart';
import 'package:parkingapp/models/timeslot.dart';
import 'package:parkingapp/widgets/hoverbutton.dart';
import 'package:http/http.dart' as http;

class ManageParkingLots extends StatefulWidget {
  const ManageParkingLots({Key? key}) : super(key: key);

  @override
  _ManageParkingLotsState createState() => _ManageParkingLotsState();
}

class _ManageParkingLotsState extends State<ManageParkingLots> {
  final Color googleColor = const Color(0xffDF4A32);
  var locationcontroller = TextEditingController();
  List<ParkingLotData> pllist = [];

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Container(
              margin: const EdgeInsets.only(right: 15, left: 15),
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
                        await getData();
                      },
                      child: const Text(
                        "SEARCH",
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  }))),
          Expanded(
            child: Container(
              child: GridView(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 5.0,
                    mainAxisSpacing: 5.0,
                  ),
                  children: pllist.map((e) {
                    var color = e.occupied ? googleColor : Color(0xff2FC4B2);
                    return OnHoverButton(builder: (isHovered) {
                      return SizedBox(
                        height: 100,
                        width: 100,
                        child: Container(
                          margin: const EdgeInsets.all(10),
                          color: Colors.yellow,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(color),
                            ),
                            onPressed: () {
                              _showDialog(e);
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "${e.pl.lotID}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 23),
                                ),
                                if (e.occupied)
                                  IconButton(
                                      onPressed: () {},
                                      icon: Icon(CupertinoIcons.car))
                              ],
                            ),
                          ),
                        ),
                      );
                    });
                  }).toList()),
            ),
          ),
        ],
      ),
    );
  }

  Future getData() async {
    Uri url = Uri.parse("http://localhost:8080/fetchParkingLotsloc");

    final response = await http.get(url, headers: {
      'location': locationcontroller.text,
      'time': DateTime.now().millisecondsSinceEpoch.toString()
    });
    setState(() {
      pllist = List<ParkingLotData>.from(
          json.decode(response.body).map((e) => ParkingLotData.fromJson(e)));
    });
  }

  deletepl(ParkingLotData p) async {
    Uri url = Uri.parse("http://localhost:8080/deleteParkingLot");

    final response = await http.delete(url, headers: {
      'docid': p.docID,
    });
    getData();
    _showDelDialog(p.pl.lotID.toString());
  }

  void _showDelDialog(String lotID) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("!!"),
          content: new Text("${lotID} of ${locationcontroller.text} removed"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showDialog(ParkingLotData pld) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("!!"),
          content: Container(
            height: 350,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.all(8),
                          child: const Text("LOCATION: ",
                              style: TextStyle(
                                  color: Color(0xff2FC4B2),
                                  fontWeight: FontWeight.w800)),
                        ),
                        Container(
                          margin: EdgeInsets.all(8),
                          child: const Text("PARKING LOT NUMBER: ",
                              style: TextStyle(
                                  color: Color(0xff2FC4B2),
                                  fontWeight: FontWeight.w800)),
                        ),
                        Container(
                          margin: EdgeInsets.all(8),
                          child: const Text("PARKING LOT ID: ",
                              style: TextStyle(
                                  color: Color(0xff2FC4B2),
                                  fontWeight: FontWeight.w800)),
                        ),
                        Container(
                          margin: EdgeInsets.all(8),
                          child: const Text("SIZE: ",
                              style: TextStyle(
                                  color: Color(0xff2FC4B2),
                                  fontWeight: FontWeight.w800)),
                        ),
                        Container(
                          margin: EdgeInsets.all(8),
                          child: const Text("PRICE: ",
                              style: TextStyle(
                                  color: Color(0xff2FC4B2),
                                  fontWeight: FontWeight.w800)),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            margin: EdgeInsets.all(8),
                            child: Text(pld.pl.location)),
                        Container(
                            margin: EdgeInsets.all(8),
                            child: Text(pld.pl.lotID.toString())),
                        Container(
                            margin: EdgeInsets.all(8), child: Text(pld.docID)),
                        Container(
                            margin: EdgeInsets.all(8),
                            child: Text(pld.pl.size.toString())),
                        Container(
                          margin: EdgeInsets.all(8),
                          child: Text(pld.pl.price.toString()),
                        )
                      ],
                    ),
                  ],
                ),
                IconButton(
                    onPressed: () {
                      deletepl(pld);
                    },
                    icon: Icon(CupertinoIcons.delete)),
              ],
            ),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

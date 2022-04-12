import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:parkingapp/models/parkinglot.dart';
import 'package:parkingapp/models/parkinglotlistdata.dart';
import 'package:parkingapp/models/timeslot.dart';
import 'package:parkingapp/models/workerlistdata.dart';
import 'package:parkingapp/widgets/hoverbutton.dart';
import 'package:http/http.dart' as http;

class ManageWorkers extends StatefulWidget {
  const ManageWorkers({Key? key}) : super(key: key);

  @override
  _ManageWorkersState createState() => _ManageWorkersState();
}

class _ManageWorkersState extends State<ManageWorkers> {
  final Color googleColor = const Color(0xffDF4A32);
  var locationcontroller = TextEditingController();
  List<WorkerData> wlist = [];

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
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 175,
                  child: Text(
                    "worker name",
                    style: const TextStyle(
                        fontWeight: FontWeight.w800, fontSize: 12),
                  ),
                ),
                Container(
                  width: 175,
                  child: Text(
                    "rating",
                    style: const TextStyle(
                        fontWeight: FontWeight.w800, fontSize: 12),
                  ),
                ),
                Container(
                  width: 175,
                  child: Text(
                    "# jobs completed",
                    style: const TextStyle(
                        fontWeight: FontWeight.w800, fontSize: 12),
                  ),
                ),
                Container(
                  width: 175,
                  child: Text(
                    "date of joining",
                    style: const TextStyle(
                        fontWeight: FontWeight.w800, fontSize: 12),
                  ),
                ),
                IconButton(onPressed: () {}, icon: Icon(CupertinoIcons.delete))
              ],
            ),
          ),
          Expanded(
            child: Container(
              child: ListView(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  children: wlist.map((e) {
                    return OnHoverButton(builder: (isHovered) {
                      return SizedBox(
                        height: 100,
                        child: Container(
                          margin: const EdgeInsets.all(10),
                          color: Colors.yellow,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.black),
                            ),
                            onPressed: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 175,
                                  child: Text(
                                    "${e.worker.workername}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12),
                                  ),
                                ),
                                Container(
                                  width: 175,
                                  child: Text(
                                    "${e.worker.rating}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12),
                                  ),
                                ),
                                Container(
                                  width: 175,
                                  child: Text(
                                    "${e.worker.jobscompleted}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12),
                                  ),
                                ),
                                Container(
                                  width: 175,
                                  child: Text(
                                    "${DateTime.fromMillisecondsSinceEpoch(e.worker.dateofjoining)}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12),
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      deleteworker(e);
                                    },
                                    icon: Icon(CupertinoIcons.delete))
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
    Uri url = Uri.parse("http://localhost:8080/getWorkerAtLocation");

    final response = await http.get(url, headers: {
      'location': locationcontroller.text,
    });
    setState(() {
      wlist = List<WorkerData>.from(
          json.decode(response.body).map((e) => WorkerData.fromJson(e)));
    });
  }

  deleteworker(WorkerData w) async {
    Uri url = Uri.parse("http://localhost:8080/deleteWorker");

    final response = await http.delete(url, headers: {
      'docid': w.docID,
    });
    getData();
    _showDialog(w.worker.workername);
  }

  void _showDialog(String worker) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("!!"),
          content: new Text("${worker} removed"),
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

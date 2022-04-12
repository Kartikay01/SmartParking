import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parkingapp/models/timeslotlistdata.dart';
import 'package:http/http.dart' as http;
import 'package:parkingapp/widgets/hoverbutton.dart';

class BookingsPage extends StatefulWidget {
  const BookingsPage({Key? key}) : super(key: key);

  @override
  _BookingsPageState createState() => _BookingsPageState();
}

class _BookingsPageState extends State<BookingsPage> {
  List<TimeslotData> tslist = [];
  TimeslotData ts = TimeslotData();

  Future getData() async {
    Uri url = Uri.parse("http://localhost:8080/userBookings");

    final response = await http
        .get(url, headers: {'uid': FirebaseAuth.instance.currentUser!.uid});
    setState(() {
      tslist = List<TimeslotData>.from(
          json.decode(response.body).map((e) => TimeslotData.fromJson(e)));
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        width: 500,
        child: Column(
          children: [
            /*SizedBox(
                width: double.infinity,
                height: 80,
                child: Container(
                    margin: EdgeInsets.all(15), // <-- match_parent
                    child: OnHoverButton(builder: (isHovered) {
                      final boxcolor =
                          isHovered ? Color(0xff2FC4B2) : Colors.black;

                      return ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(boxcolor),
                        ),
                        onPressed: () async {
                          await getData();
                        },
                        child: Text(
                          "All bookings",
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    }))),*/
            Expanded(
              child: ListView(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  children: tslist.map((e) {
                    var color;
                    if (e.timeslots.checkout <
                        DateTime.now().millisecondsSinceEpoch) {
                      color = Colors.black;
                    } else {
                      color = Color(0xff2FC4B2);
                    }
                    return OnHoverButton(builder: (isHovered) {
                      return SizedBox(
                        height: 180,
                        width: 500,
                        child: Container(
                          margin: EdgeInsets.all(10),
                          color: Colors.yellow,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(color),
                            ),
                            onPressed: () {},
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Booking ID: ${e.getdocID()}\nLot ID: ${e.timeslots.lotID}\nBooked at: ${DateTime.fromMillisecondsSinceEpoch(e.timeslots.timestamp)}\n${DateTime.fromMillisecondsSinceEpoch(e.timeslots.checkin)} to ${DateTime.fromMillisecondsSinceEpoch(e.timeslots.checkout)}\ncost: Rs. ${e.timeslots.cost}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 10),
                                ),
                                Row(
                                  children: [
                                    if (DateTime.now().millisecondsSinceEpoch +
                                            3600000 <
                                        e.timeslots.checkin)
                                      TextButton(
                                          onPressed: () {
                                            int time = DateTime.now()
                                                .millisecondsSinceEpoch;
                                            cancelBooking(
                                                e.docID, time.toString());
                                          },
                                          child: Container(
                                            color: Colors.red,
                                            child: Text("cancel",
                                                style: TextStyle(
                                                    color: Colors.white)),
                                          )),
                                    if (DateTime.now().millisecondsSinceEpoch >
                                            e.timeslots.checkout &&
                                        e.timeslots.vote == 0)
                                      Container(
                                          child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Text("rate our service: "),
                                          IconButton(
                                              hoverColor: Colors.green,
                                              onPressed: () {
                                                vote(e, 1);
                                              },
                                              icon: Icon(
                                                  CupertinoIcons.up_arrow)),
                                          IconButton(
                                              hoverColor: Colors.red,
                                              onPressed: () {
                                                vote(e, -1);
                                              },
                                              icon: Icon(
                                                  CupertinoIcons.down_arrow))
                                        ],
                                      ))
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    });
                  }).toList()),
            )
          ],
        ),
      ),
    );
  }

  Future cancelBooking(String tsi, String time) async {
    Uri url = Uri.parse("http://localhost:8080/cancelBooking");

    final response =
        await http.delete(url, headers: {'timeslotID': tsi, 'time': time});
    setState(() {
      getData();
    });
  }

  Future vote(TimeslotData tsd, int vote) async {
    Uri url = Uri.parse("http://localhost:8080/updateWorker");
    Uri url1 = Uri.parse("http://localhost:8080/voteWorker");
    final response = await http.put(url,
        headers: {'docid': tsd.timeslots.worker, 'vote': vote.toString()});
    final response1 = await http
        .put(url1, headers: {'docid': tsd.docID, 'vote': vote.toString()});
    setState(() {
      getData();
    });
  }
}

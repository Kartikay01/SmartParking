import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:parkingapp/models/parkinglotlistdata.dart';
import 'package:parkingapp/models/workerlistdata.dart';
import 'package:parkingapp/views/parkinglotpage.dart';
import 'package:parkingapp/widgets/hoverbutton.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  int cartype = 0;
  var _cartype;
  List<String> cartypelist = ["hatchback", "sedan", "SUV"];
  var locationController = TextEditingController();
  String _date = "date";
  String _checkintime = "check-in time";
  String _checkouttime = "check-out time";
  List<String> sizelist = ["hatchback", "sedan", "SUV"];
  late int year;
  late int month;
  late int day;
  late int checkinhour;
  late int checkinminute;
  late int checkinsecond;
  late int checkouthour;
  late int checkoutminute;
  late int checkoutsecond;
  List<ParkingLotData> pllist = [];
  List<WorkerData> wlist = [];
  ParkingLotData pl = ParkingLotData();

  Future getData() async {
    DateTime cindt =
        DateTime(year, month, day, checkinhour, checkinminute, checkinsecond);
    DateTime coutdt = DateTime(
        year, month, day, checkouthour, checkoutminute, checkoutsecond);
    int checkindt = cindt.millisecondsSinceEpoch;
    int checkoutdt = coutdt.millisecondsSinceEpoch;
    Uri url = Uri.parse("http://localhost:8080/fetchParkingLots");
    Uri url2 = Uri.parse("http://localhost:8080/getWorkerAtLocation");

    final response = await http.get(url, headers: {
      'location': locationController.text,
      'checkin': checkindt.toString(),
      'checkout': checkoutdt.toString(),
      'size': '0'
    });
    final response2 = await http.get(url2, headers: {
      'location': locationController.text,
    });
    setState(() {
      wlist = List<WorkerData>.from(
          json.decode(response2.body).map((e) => WorkerData.fromJson(e)));
      pllist = List<ParkingLotData>.from(
          json.decode(response.body).map((e) => ParkingLotData.fromJson(e)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        width: 500,
        child: Column(children: <Widget>[
          Container(
              margin: const EdgeInsets.only(bottom: 15, right: 15, left: 15),
              child: TextField(
                controller: locationController,
                autofocus: false,
                style: const TextStyle(fontSize: 15.0, color: Colors.black),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Please enter location',
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
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextButton(
                  onPressed: () {
                    DatePicker.showDatePicker(context,
                        theme: DatePickerTheme(
                          containerHeight: 210.0,
                        ),
                        showTitleActions: true,
                        minTime: DateTime(2000, 1, 1),
                        maxTime: DateTime(2022, 12, 31), onConfirm: (date) {
                      print('confirm $date');
                      year = date.year;
                      month = date.month;
                      day = date.day;
                      _date = '${date.year} - ${date.month} - ${date.day}';
                      setState(() {});
                    }, currentTime: DateTime.now(), locale: LocaleType.en);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    color: Colors.grey.shade200,
                    margin: const EdgeInsets.only(right: 7, left: 7),
                    padding: const EdgeInsets.only(right: 11, left: 11),
                    height: 50.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Container(
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    " $_date",
                                    style: TextStyle(
                                        color: Colors.grey.shade700,
                                        fontSize: 15.0),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        Icon(
                          Icons.date_range,
                          size: 20.0,
                          color: Color(0xff2FC4B2),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextButton(
                  onPressed: () {
                    DatePicker.showTimePicker(context,
                        theme: DatePickerTheme(
                          containerHeight: 210.0,
                        ),
                        showTitleActions: true, onConfirm: (time) {
                      print('confirm $time');
                      checkinhour = time.hour;
                      checkinminute = time.minute;
                      checkinsecond = time.second;
                      _checkintime =
                          '${time.hour} : ${time.minute} : ${time.second}';
                      setState(() {});
                    }, currentTime: DateTime.now(), locale: LocaleType.en);
                    setState(() {});
                  },
                  child: Container(
                    color: Colors.grey.shade200,
                    margin: const EdgeInsets.only(right: 7, left: 7),
                    padding: const EdgeInsets.only(right: 11, left: 11),
                    alignment: Alignment.center,
                    height: 50.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Container(
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    " $_checkintime",
                                    style: TextStyle(
                                        color: Colors.grey.shade700,
                                        fontSize: 15.0),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        Icon(
                          Icons.access_time,
                          size: 20,
                          color: Color(0xff2FC4B2),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextButton(
                  onPressed: () {
                    DatePicker.showTimePicker(context,
                        theme: DatePickerTheme(
                          containerHeight: 210.0,
                        ),
                        showTitleActions: true, onConfirm: (time) {
                      print('confirm $time');
                      checkouthour = time.hour;
                      checkoutminute = time.minute;
                      checkoutsecond = time.second;
                      _checkouttime =
                          '${time.hour} : ${time.minute} : ${time.second}';
                      setState(() {});
                    }, currentTime: DateTime.now(), locale: LocaleType.en);
                    setState(() {});
                  },
                  child: Container(
                    color: Colors.grey.shade200,
                    margin: const EdgeInsets.only(right: 7, left: 7),
                    padding: const EdgeInsets.only(right: 11, left: 11),
                    alignment: Alignment.center,
                    height: 50.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Container(
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    " $_checkouttime",
                                    style: TextStyle(
                                        color: Colors.grey.shade700,
                                        fontSize: 15.0),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        Icon(
                          Icons.access_time,
                          size: 20,
                          color: Color(0xff2FC4B2),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  color: Colors.grey.shade200,
                  margin: const EdgeInsets.all(15),
                  padding: const EdgeInsets.all(11),
                  alignment: Alignment.center,
                  height: 50.0,
                  child: DropdownButton(
                      hint: Text(
                        "select car type",
                        style: TextStyle(
                          fontSize: 15.0,
                        ),
                      ),
                      underline: SizedBox(),
                      isExpanded: true,
                      style: TextStyle(
                        fontSize: 15.0,
                      ),
                      value: _cartype,
                      items: cartypelist.map((String s) {
                        return DropdownMenuItem<String>(
                          value: s,
                          child: Text(s),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _cartype = value;
                          cartype = cartypelist.indexOf(_cartype);
                        });
                      }),
                ),
              ],
            ),
          ),
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
            child: ListView(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                children: pllist.map((e) {
                  return OnHoverButton(builder: (isHovered) {
                    return SizedBox(
                      height: 150,
                      width: 300,
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        color: Colors.yellow,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.black),
                          ),
                          onPressed: () {
                            DateTime cindt = DateTime(year, month, day,
                                checkinhour, checkinminute, checkinsecond);
                            DateTime coutdt = DateTime(year, month, day,
                                checkouthour, checkoutminute, checkoutsecond);
                            int checkindt = cindt.millisecondsSinceEpoch;
                            int checkoutdt = coutdt.millisecondsSinceEpoch;
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ParkingLotPage(
                                    pl: e,
                                    date: _date,
                                    checkin: _checkintime,
                                    checkout: _checkouttime,
                                    workerslist: wlist,
                                    checkoutdt: checkoutdt,
                                    checkindt: checkindt,
                                  ),
                                ));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    e.pl.lotID.toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w800,
                                        fontSize: 23),
                                  ),
                                  Text(
                                    e.pl.location,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w800,
                                        fontSize: 23),
                                  ),
                                ],
                              ),
                              if (cartype == e.pl.size)
                                Icon(CupertinoIcons.star),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "cost: ${e.totalcost.toString()}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 23),
                                  ),
                                  Text(
                                    "ID: ${e.docID}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 23),
                                  ),
                                  Text(
                                    "size: ${sizelist[e.pl.size]}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 23),
                                  ),
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
        ]),
      ),
    );
  }
}

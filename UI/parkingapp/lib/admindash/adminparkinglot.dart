import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:parkingapp/admindash/addparkinglot.dart';
import 'package:parkingapp/admindash/manageparkinglots.dart';
import 'package:parkingapp/widgets/hoverbutton.dart';

class AdminParkingLot extends StatefulWidget {
  const AdminParkingLot({Key? key}) : super(key: key);

  @override
  _AdminParkingLotState createState() => _AdminParkingLotState();
}

class _AdminParkingLotState extends State<AdminParkingLot> {
  int view = 1;
  int id = 1;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        width: 800,
        child: Column(
          children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                      child: Row(children: [
                    Radio(
                      autofocus: false,
                      activeColor: Colors.grey,
                      value: 1,
                      groupValue: id,
                      onChanged: (val) {
                        setState(() {
                          view = 1;
                          id = 1;
                        });
                      },
                    ),
                    Text(
                      'Add Parking Lot',
                    ),
                  ])),
                  Container(
                    child: Row(children: [
                      Radio(
                        autofocus: false,
                        activeColor: Colors.grey,
                        value: 2,
                        groupValue: id,
                        onChanged: (val) {
                          setState(() {
                            view = 2;
                            id = 2;
                          });
                        },
                      ),
                      Container(
                          margin: EdgeInsets.only(right: 60),
                          child: Text(
                            'View Parking Lots',
                          ))
                    ]),
                  ),
                ]),
            SizedBox(
              height: 30,
            ),
            if (view == 1) AddParkingLot() else ManageParkingLots()
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:parkingapp/admindash/addworker.dart';
import 'package:parkingapp/admindash/manageworkers.dart';

class Workerspage extends StatefulWidget {
  const Workerspage({Key? key}) : super(key: key);

  @override
  _WorkerspageState createState() => _WorkerspageState();
}

class _WorkerspageState extends State<Workerspage> {
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
                      'Add Worker',
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
                            'View Workers',
                          ))
                    ]),
                  ),
                ]),
            SizedBox(
              height: 30,
            ),
            if (view == 1) AddWorker() else ManageWorkers()
          ],
        ),
      ),
    );
  }
}

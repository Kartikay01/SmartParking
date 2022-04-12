/*import 'package:flutter/material.dart';

class UpdateBooking extends StatefulWidget {
  const UpdateBooking({ Key? key }) : super(key: key);

  @override
  _UpdateBookingState createState() => _UpdateBookingState();
}

class _UpdateBookingState extends State<UpdateBooking> {
  var _worker;
  bool carwash = false;
  bool tyrechange = false;
  bool apcheck = false;
  int servicecost = 0;

  List<int> services = [];
  Future book() async {
    DateTime ts = DateTime.now();
    int tsint = ts.millisecondsSinceEpoch;
    var dio = Dio();
    var response = await dio.post('http://localhost:8080/bookTimeLot', data: {
      "checkin": widget.checkindt,
      "checkout": widget.checkoutdt,
      "lotID": widget.pl.docID,
      "user": FirebaseAuth.instance.currentUser!.uid,
      "worker": _worker,
      "timestamp": tsint,
      "servicesArrayList": services,
      "cost": widget.pl.totalcost + servicecost
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
            color: Colors.white,
            height: 700,
            width: 500,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Row(
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
                            child: const Text("TIME: ",
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
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              margin: EdgeInsets.all(8),
                              child: Text(widget.pl.pl.location)),
                          Container(
                              margin: EdgeInsets.all(8),
                              child:
                                  Text("${widget.checkin}-${widget.checkout}")),
                          Container(
                              margin: EdgeInsets.all(8),
                              child: Text("${widget.pl.pl.lotID}")),
                          Container(
                              margin: EdgeInsets.all(8),
                              child: Text(widget.pl.docID)),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 25),
                Text("SERVICES",
                    style: TextStyle(
                        color: Color(0xff2FC4B2), fontWeight: FontWeight.w800)),
                Container(
                  width: 300,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text("Car Wash"),
                          Switch(
                              inactiveThumbColor: Colors.black,
                              activeColor: Color(0xff2FC4B2),
                              value: carwash,
                              onChanged: (value) => {
                                    setState(() => carwash = value),
                                    setservices()
                                  }),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text("Tyre Change"),
                          Switch(
                              inactiveThumbColor: Colors.black,
                              activeColor: Color(0xff2FC4B2),
                              value: tyrechange,
                              onChanged: (value) => {
                                    setState(() => tyrechange = value),
                                    setservices()
                                  }),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text("Air Pressure Check"),
                          Switch(
                              inactiveThumbColor: Colors.black,
                              activeColor: Color(0xff2FC4B2),
                              value: apcheck,
                              onChanged: (value) => {
                                    setState(() => apcheck = value),
                                    setservices()
                                  }),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 200,
                  padding: const EdgeInsets.only(left: 14.0, right: 14.0),
                  margin: EdgeInsets.only(bottom: 0),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                  ),
                  child: IgnorePointer(
                    ignoring: !(apcheck || tyrechange || carwash),
                    child: DropdownButton(
                        hint: Text(
                          "select worker",
                          style: TextStyle(
                              fontSize: 15.0,
                              color: (apcheck || tyrechange || carwash)
                                  ? Colors.grey.shade600
                                  : Colors.grey.shade400),
                        ),
                        underline: SizedBox(),
                        isExpanded: true,
                        style: TextStyle(
                            fontSize: 15.0,
                            color: (apcheck || tyrechange || carwash)
                                ? Colors.black
                                : Colors.grey.shade400),
                        value: _worker,
                        items: widget.workerslist.map((WorkerData w) {
                          return DropdownMenuItem<String>(
                            value: w.docID,
                            child: Text(
                                "${w.worker.workername} (${w.worker.rating})"),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _worker = value;
                          });
                        }),
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.all(8),
                            child: const Text("COST: ",
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
                              child: Text(
                                  "${widget.pl.totalcost}+${servicecost}")),
                          Container(
                              margin: EdgeInsets.symmetric(horizontal: 8),
                              child: Text(
                                  "total:${widget.pl.totalcost + servicecost}")),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 25),
                SizedBox(
                    width: 400,
                    height: 80,
                    child: Container(
                        margin: EdgeInsets.all(15), // <-- match_parent
                        child: OnHoverButton(builder: (isHovered) {
                          final boxcolor =
                              isHovered ? Color(0xff2FC4B2) : Colors.black;

                          return ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(boxcolor),
                            ),
                            onPressed: () async {
                              /*if (carwash) {
                                services.add(0);
                              }
                              if (tyrechange) {
                                services.add(1);
                              }
                              if (apcheck) {
                                services.add(2);
                              }*/
                              if (!(apcheck || tyrechange || carwash)) {
                                _worker = "nil";
                              }
                              if ((apcheck || tyrechange || carwash) &&
                                  _worker == null) {
                                _showDialog();
                              } else {
                                await book();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => BookingSuccessful(),
                                    ));
                              }
                            },
                            child: const Text(
                              "BOOK",
                              style: TextStyle(color: Colors.white),
                            ),
                          );
                        }))),
              ],
            )),
      ),
    );
  }

  setservices() {
    setState(() {
      services = [];
      if (carwash) {
        services.add(0);
      }
      if (tyrechange) {
        services.add(1);
      }
      if (apcheck) {
        services.add(2);
      }
      servicecost = 25 * services.length;
    });
  }

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("!!"),
          content: new Text("choose worker"),
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
}*/
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:parkingapp/widgets/hoverbutton.dart';

class AddParkingLot extends StatefulWidget {
  const AddParkingLot({Key? key}) : super(key: key);

  @override
  _AddParkingLotState createState() => _AddParkingLotState();
}

class _AddParkingLotState extends State<AddParkingLot> {
  var locationcontroller = TextEditingController();
  var pricecontroller = TextEditingController();
  int cartype = 0;
  var _cartype;
  List<String> cartypelist = ["hatchback", "sedan", "SUV"];
  int lotid = 0;
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
        Container(
            margin: const EdgeInsets.only(bottom: 15, right: 15, left: 15),
            child: TextField(
              controller: pricecontroller,
              autofocus: false,
              style: const TextStyle(fontSize: 15.0, color: Colors.black),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'price',
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
                      lotid = await addpl();
                      _showDialog(lotid);
                    },
                    child: const Text(
                      "ADD PARKING LOT",
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                }))),
      ],
    );
  }

  void _showDialog(int number) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("!!"),
          content: new Text(
              "parking lot ${number} in ${locationcontroller.text} created"),
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

  Future addpl() async {
    DateTime ts = DateTime.now();
    int tsint = ts.millisecondsSinceEpoch;
    var dio = Dio();
    var response =
        await dio.post('http://localhost:8080/createParkingLot', data: {
      "location": locationcontroller.text,
      "size": int.parse(cartype.toString()),
      "price": int.parse(pricecontroller.text)
    });
    return response.data;
  }
}

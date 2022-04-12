import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:parkingapp/main.dart';
import 'package:parkingapp/views/search.dart';
import 'package:parkingapp/widgets/hoverbutton.dart';

class BookingSuccessful extends StatelessWidget {
  const BookingSuccessful({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 500,
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    FontAwesomeIcons.checkCircle,
                    color: Color(0xff2FC4B2),
                  ),
                  Text("Booking Successful!")
                ],
              )),
            ),
            OnHoverButton(builder: (isHovered) {
              final boxcolor = isHovered ? Color(0xff2FC4B2) : Colors.black;

              return TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(boxcolor),
                ),
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      '/SearchPage', (Route<dynamic> route) => false);
                },
                child: const Text(
                  "go to home page",
                  style: TextStyle(color: Colors.white),
                ),
              );
            })
          ],
        ));
  }
}

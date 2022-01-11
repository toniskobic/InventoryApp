import 'package:flutter/material.dart';

TextStyle navBarStyle() {
  return TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
}

TextStyle resourceDetailsStyle() {
  return TextStyle(fontFamily: 'Mulish', color: Colors.black, fontSize: 20);
}

TextStyle tabBarStyle() {
  return TextStyle(
    fontFamily: 'Mulish',
    fontSize: 16,
    letterSpacing: 0.8,
    fontWeight: FontWeight.w600,
  );
}

TextStyle filterStyle() {
  return TextStyle(
    fontFamily: 'OpenSans',
    fontSize: 20,
    letterSpacing: 1.2,
    fontWeight: FontWeight.w600,
  );
}

ButtonStyle resourceButton() {
  return ElevatedButton.styleFrom(
      primary: Colors.lightBlue,
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold));
}

Widget circularWaiting() {
  return Center(
    child: SizedBox(
        width: 40.0,
        height: 40.0,
        child: const CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue))),
  );
}

Divider divider() {
  return Divider(
      thickness: 1, indent: 10, endIndent: 10, color: Colors.black12);
}

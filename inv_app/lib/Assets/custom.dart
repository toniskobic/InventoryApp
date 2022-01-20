import 'package:flutter/material.dart';

TextStyle navBarStyle() {
  return TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
}

TextStyle resourceDetailsStyle() {
  return TextStyle(fontFamily: 'Mulish', color: Colors.black, fontSize: 20);
}

TextStyle tabBarStyle() {
  return TextStyle(
    fontSize: 16,
    letterSpacing: 1,
    fontWeight: FontWeight.w600,
  );
}

TextStyle filterStyle() {
  return TextStyle(
    fontSize: 17,
    letterSpacing: 1,
    fontWeight: FontWeight.w600,
  );
}

ButtonStyle resourceButton() {
  return ElevatedButton.styleFrom(
    primary: Colors.blue[600],
    padding: EdgeInsets.symmetric(horizontal: 150, vertical: 18),
    textStyle: TextStyle(fontSize: 20, letterSpacing: 1),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
  );
}

ButtonStyle filterButon() {
  return ElevatedButton.styleFrom(
    primary: Color(0xFF2f80ed),
    padding: EdgeInsets.symmetric(horizontal: 150, vertical: 18),
    textStyle: const TextStyle(fontSize: 20, letterSpacing: 1),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
  );
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

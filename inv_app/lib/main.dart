import 'package:flutter/material.dart';
import 'pocetna_stranica.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
     
      debugShowCheckedModeBanner:false,
      home: HomepageWidget(),
        );
  }
}



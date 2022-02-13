import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inv_app/Views/Forms/login.dart';
import 'package:inv_app/Views/general.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Login(),
    );
  }
}

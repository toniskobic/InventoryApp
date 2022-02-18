import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:inv_app/Assets/constants.dart';
import 'package:inv_app/Classes/user.dart';
import 'package:flutter/material.dart';

LoginRequest(User pUser, BuildContext context) async {
  var url = Uri.parse(SIGN_IN);
  var response = await http
      .post(url, body: {"identifier": pUser.email, "password": pUser.password});

  if (response.statusCode == 200) {
    //var jsonResponse = json.decode(response.body);
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/modules', (Route<dynamic> route) => false);
  } else {
    Get.snackbar('Login Error',
        'Incorrect username/email or password \nEnter a valid username/password and try again.',
        duration: Duration(seconds: 3), backgroundColor: Colors.red[100]);
  }
}

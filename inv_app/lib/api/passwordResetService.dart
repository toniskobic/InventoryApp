import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:inv_app/Assets/constants.dart';
import 'package:inv_app/Classes/user.dart';
import 'package:flutter/material.dart';
import '../Views/Forms/login.dart';

NewPasswordRequest(User pUser, BuildContext context) async {
  var url = Uri.parse(NEW_PASSWORD);
  var response = await http.post(url, body: {"identifier": pUser.email});

  if (response.statusCode == 200) {
    Get.snackbar(
        'Request approved', 'New password has been sent on your email.',
        duration: Duration(seconds: 3), backgroundColor: Colors.grey.shade100);
  } else {
    Get.snackbar('Incorrect email', 'Enter a valid emal and try again.',
        duration: Duration(seconds: 3), backgroundColor: Colors.red[100]);
  }
}

import 'package:get/get.dart';
import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:inv_app/Assets/constants.dart';
import 'package:inv_app/Classes/user.dart';
import 'package:flutter/material.dart';
import 'package:inv_app/Model/userStorage.dart';
import 'package:inv_app/api/resourceService.dart';
import 'package:inv_app/boxes.dart';


Future<String> newPasswordRequest(
    BuildContext context,
    String currentPass,
    String newPass,
    String confirmPass
    ) async {

  final response = await http.post(Uri.parse(PASSWORD),
      headers: header,
      body: jsonEncode({
        "identifier": "",
        "password": currentPass,
        "newPassword": newPass,
        "confirmPassword": confirmPass
      }));

  if (response.statusCode == 200) {
    Get.snackbar(
        'Request approved', 'You successfully changed your password.',
        duration: Duration(seconds: 3), backgroundColor: Colors.grey.shade100);
  } else {
    Get.snackbar('Bad request', 'Please try that again.',
        duration: Duration(seconds: 3), backgroundColor: Colors.red[100]);
  }

  return response.body;
}

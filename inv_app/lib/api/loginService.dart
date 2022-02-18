import 'package:get/get.dart';
import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:inv_app/Assets/constants.dart';
import 'package:inv_app/Classes/user.dart';
import 'package:flutter/material.dart';
import 'package:inv_app/Model/userStorage.dart';
import 'package:inv_app/boxes.dart';

void addUser(int? userId, String? jwt, int? organizationId) async {
  bool exists = await Hive.boxExists('users');
  var box;
  if (exists) {
    box = Hive.box<UserStorage>('users');
  } else {
    box = await Hive.openBox<UserStorage>('users');
  }
  box.deleteAll(box.keys);
  final user = UserStorage()
    ..userId = userId
    ..jwt = jwt
    ..organizationId = organizationId;

  box.add(user);
  //box.put("user", user);

  print(box);
}

LoginRequest(User pUser, BuildContext context) async {
  var url = Uri.parse(SIGN_IN);
  var response = await http
      .post(url, body: {"identifier": pUser.email, "password": pUser.password});

  if (response.statusCode == 200) {
    var jsonResponse = json.decode(response.body);
    print(jsonResponse);

    addUser(
        jsonResponse['user']['id'],
        jsonResponse['jwt'],
        jsonResponse['user']['organizations'].isEmpty
            ? 1
            : jsonResponse['user']['organizations'][0]['id']);
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/modules', (Route<dynamic> route) => false);
  } else {
    Get.snackbar('Login Error',
        'Incorrect username/email or password \nEnter a valid username/password and try again.',
        duration: Duration(seconds: 3), backgroundColor: Colors.red[100]);
  }
}

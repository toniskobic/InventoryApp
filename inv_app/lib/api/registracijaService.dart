import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:inv_app/Assets/constants.dart';
import 'package:inv_app/users.dart';

Future signUp(User pUser) async {
  final response = await http.post(Uri.parse(SIGN_UP),
      // Send authorization headers to the backend.
      body: {
        "name": pUser.name,
        "surname": pUser.surname,
        "username": "pjohn" //pUser.username
        ,
        "email": pUser.email,
        "password": pUser.password
      });
  final responseJson = jsonDecode(response.body);

  print(responseJson);
  /* return Album.fromJson(responseJson);
}


  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
    );
  } */
}

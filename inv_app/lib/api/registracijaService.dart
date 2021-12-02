import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:inv_app/Assets/constants.dart';
import 'package:inv_app/users.dart';

Future signUp(User pUser) async {
  final response = await http.post(Uri.parse(SIGN_UP), body: {
    "name": pUser.name,
    "surname": pUser.surname,
    "username": pUser.username,
    "email": pUser.email,
    "password": pUser.password
  });
  final responseJson = jsonDecode(response.body);
  final errorMessage = responseJson['message'][0]['messages'][0]['message'];
  if (response.statusCode == 200) {
    return User.fromJson(responseJson);
  } else
    return throw Exception(errorMessage);
}

import 'package:http/http.dart' as http;
import 'package:inv_app/Assets/constants.dart';
import 'package:inv_app/Classes/user.dart';
import 'package:flutter/material.dart';
import '../Views/modules.dart';

/*
logIn(User pUser) async {
  var response = await http.post(Uri.parse(SIGN_IN),
      body: {"identifier": pUser.email, "password": pUser.password});
  var responseJson = jsonDecode(response.body);
  print(responseJson);
  return responseJson;
} */

LoginRequest(User pUser, BuildContext context) async {
  var url = Uri.parse(SIGN_IN);
  var response = await http
      .post(url, body: {"identifier": pUser.email, "password": pUser.password});

  if (response.statusCode == 200) {
    //var jsonResponse = json.decode(response.body);
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (BuildContext context) => const Modules()),
        (Route<dynamic> route) => false);
  } else {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Incorrect username/email or password'),
            content: SingleChildScrollView(
              child: ListBody(
                children: const <Widget>[
                  Text('Enter a valid username/password and try again.'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}

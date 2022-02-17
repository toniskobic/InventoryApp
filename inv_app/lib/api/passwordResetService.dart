import 'package:http/http.dart' as http;
import 'package:inv_app/Assets/constants.dart';
import 'package:inv_app/Classes/user.dart';
import 'package:flutter/material.dart';
import '../Views/Forms/login.dart';

NewPasswordRequest(User pUser, BuildContext context) async {
  var url = Uri.parse(NEW_PASSWORD);
  var response = await http.post(url, body: {"identifier": pUser.email});

  if (response.statusCode == 200) {
    /*
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (BuildContext context) => const Login()),
        (Route<dynamic> route) => false);
    */
  } else {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Incorrect email.'),
            content: SingleChildScrollView(
              child: ListBody(
                children: const <Widget>[
                  Text('Enter a valid emal and try again.'),
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

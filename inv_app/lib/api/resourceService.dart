import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:inv_app/Assets/constants.dart';
import 'package:inv_app/Classes/resource.dart';
import 'package:inv_app/Classes/user.dart';

Future getResources() async {
  final token =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTAsImlhdCI6MTYzODQ4MDQ4MSwiZXhwIjoxNjQxMDcyNDgxfQ.leG2k2g--UoImag3NI3f0Be4Qnb6GzOFkxKHLWQ5AzE';
  final response = await http.get(
    Uri.parse(RESURS),
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    },
  );

  final responseJson = jsonDecode(response.body);
  Future<List<Resource>> ReadJsonData() async {
    final list = responseJson as List<dynamic>;

    print(list[1]);
    //map json and initialize using DataModel
    return list.map((e) => Resource.fromJson(e)).toList();
  }

  ReadJsonData();

  /* if (response.statusCode == 200) {
    return Resource.fromJson(responseJson);
  } else {
    final errorMessage = responseJson['message'][0]['messages'][0]['message'];
    return throw Exception(errorMessage);
  } */
}

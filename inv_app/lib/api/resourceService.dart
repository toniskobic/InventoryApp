import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:inv_app/Assets/constants.dart';
import 'package:inv_app/Classes/resource.dart';
import 'package:inv_app/Classes/user.dart';

List<Resource> parseResource(String responseBody) {
  final list = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return list.map<Resource>((json) => Resource.fromJson(json)).toList();
}

Future<List<Resource>> getResources() async {
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

  if (response.statusCode == 200)
    return parseResource(response.body);
  else
    return [];
}

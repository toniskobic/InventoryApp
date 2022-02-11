import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:inv_app/Assets/constants.dart';
import 'package:inv_app/Classes/resource.dart';

final token =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NDIsImlhdCI6MTY0NDU5NDQ4OCwiZXhwIjoxNjQ3MTg2NDg4fQ.zFcK32mueZp7zYdjaCATqp6FtJ_MF_fxMsdSeyVbZFo';
final header = {
  'Content-Type': 'application/json',
  'Accept': 'application/json',
  'Authorization': 'Bearer $token'
};

List<Resource> parseResource(String responseBody) {
  final list = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return list.map<Resource>((json) => Resource.fromJson(json)).toList();
}

Future<List<Resource>> getResources() async {
  final response = await http.get(
    Uri.parse(RESOURCES),
    headers: header,
  );

  if (response.statusCode == 200)
    return parseResource(response.body);
  else
    return [];
}

Future<Resource> getResourceById(int id) async {
  final response = await http.get(
    Uri.parse(RESOURCES + "/$id"),
    headers: header,
  );

  if (response.statusCode == 200) {
    final resource = jsonDecode(response.body).cast<String, dynamic>();
    return Resource.fromJson(resource);
  } else
    return Resource(id: 0);
}

Future<List<Resource?>> borrowedResources() async {
  const userId = 1; // state.user.id
  const organization = 1; // state.resoruce.organization
  final response = await http.get(
      Uri.parse(BORROWED +
          "?user.id=${userId}&resource.organization=${organization}"),
      headers: header);

  if (response.statusCode == 200)
    return parseResource(response.body);
  else
    return [];
}

//posuđivanje resursa
Future<String> borrowResource() async {
  final response = await http.post(Uri.parse(BORROWED), headers: header, body: {
    "dateFrom": "2021-12-03",
    "dateTo": "2021-12-09",
    "status": true,
    "resource": "6",
    "user": "1"
  });

  return response.body;
}

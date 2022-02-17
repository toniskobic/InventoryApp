import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:inv_app/Assets/constants.dart';
import 'package:inv_app/Classes/resource.dart';
import 'package:inv_app/Views/Home/homepage.dart';
import 'package:flutter/material.dart';

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
  const userId = 41; // state.user.id
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
Future<String> borrowResource(BuildContext context, String dateFrom,
    String dateTo, int resourceId, int userId, quantity) async {
  final response = await http.post(Uri.parse(BORROWED),
      headers: header,
      body: jsonEncode({
        "dateFrom": dateFrom,
        "dateTo": dateTo,
        "status": true,
        "resource": resourceId,
        "user": userId,
        "Quantity": quantity
      }));

  /*
  if (response.statusCode == 200) {
    Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Homepage()));
  }*/
  print(dateFrom);
  print(dateTo);
  print(resourceId);
  print(userId);
  print(quantity);
  print(response.statusCode);
  print(response.body);
  return response.body;
}

//vraćanje resursa
Future<String> returnResource(
    BuildContext context, int resourceId, int userId, comment) async {
  final response = await http.post(Uri.parse(BORROWED),
      headers: header,
      body: jsonEncode({
        "status": false,
        "resource": resourceId,
        "user": userId,
        "Comment": comment
      }));

  /*
  if (response.statusCode == 200) {
    Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Homepage()));
  }*/

  print(resourceId);
  print(userId);
  print(comment);
  print(response.statusCode);
  print(response.body);
  return response.body;
}

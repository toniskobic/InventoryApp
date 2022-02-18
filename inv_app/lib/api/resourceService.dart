import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:inv_app/Assets/constants.dart';
import 'package:inv_app/Classes/borrowed.dart';
import 'package:inv_app/Classes/resource.dart';
import 'package:inv_app/Model/userStorage.dart';
import 'package:flutter/material.dart';

Box box = Hive.box<UserStorage>('users');
UserStorage user = box.getAt(0);

final token = user.jwt;
final header = {
  'Content-Type': 'application/json',
  'Accept': 'application/json',
  'Authorization': 'Bearer $token'
};

List<Resource> parseResource(String responseBody) {
  final list = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return list.map<Resource>((json) => Resource.fromJson(json)).toList();
}

List<Borrowed> parseBorrowedResource(String responseBody) {
  final list = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return list.map<Borrowed>((json) => Borrowed.fromJson(json)).toList();
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

Future<Borrowed> getBorrowedResourceById(int id) async {
  final response = await http.get(
    Uri.parse(BORROWED + "/$id"),
    headers: header,
  );

  if (response.statusCode == 200) {
    final resource = jsonDecode(response.body).cast<String, dynamic>();
    return Borrowed.fromJson(resource);
  } else
    return Borrowed(id: 0);
}

Future<List<Borrowed?>> borrowedResources() async {
  final userId = user.userId;
  final organization = user.organizationId; // state.resoruce.organization
  final response = await http.get(
      Uri.parse(BORROWED +
          "?user.id=${userId}&resource.organization=${organization}"),
      headers: header);

  if (response.statusCode == 200)
    return parseBorrowedResource(response.body);
  else
    return [];
}

//posuđivanje resursa
Future<String> borrowResource(
    BuildContext context,
    String dateFrom,
    String dateTo,
    int resourceId,
    int quantityBorrowed,
    int availableQuantity) async {
  final response = await http.post(Uri.parse(BORROWED),
      headers: header,
      body: jsonEncode({
        "dateFrom": dateFrom,
        "dateTo": dateTo,
        "status": true,
        "resource": resourceId,
        "user": user.userId,
        "Quantity": quantityBorrowed
      }));

  int quantity = availableQuantity - quantityBorrowed;

  final response1 = await http.put(
      Uri.parse(RESOURCES + '/' + resourceId.toString()),
      headers: header,
      body: jsonEncode({"quantity": quantity}));

  if (response.statusCode == 200 && response1.statusCode == 200) {
    Get.snackbar(
        'Request approved', 'You successfully borrowed the selected resource.',
        duration: Duration(seconds: 3), backgroundColor: Colors.grey.shade100);
  } else {
    Get.snackbar('Bad request', 'Please try that again.',
        duration: Duration(seconds: 3), backgroundColor: Colors.red[100]);
  }

  return response.body;
}

//vraćanje resursa
Future<String> returnResource(
    BuildContext context,
    int resourceId,
    String comment,
    int borrowedQuantity,
    int availableQuantity,
    int borrowedId) async {
  final response = await http.put(
      Uri.parse(BORROWED + '/' + borrowedId.toString()),
      headers: header,
      body: jsonEncode({"status": false, "Comment": comment}));

  int quantity = availableQuantity + borrowedQuantity;

  final response1 = await http.put(
      Uri.parse(RESOURCES + '/' + resourceId.toString()),
      headers: header,
      body: jsonEncode({"quantity": quantity}));

  if (response.statusCode == 200 && response1.statusCode == 200) {
    Get.snackbar(
        'Request approved', 'You successfully returned the selected resource.',
        duration: Duration(seconds: 3), backgroundColor: Colors.grey.shade100);
  } else {
    Get.snackbar('Bad request', 'Please try that again.',
        duration: Duration(seconds: 3), backgroundColor: Colors.red[100]);
  }

  print(RESOURCES + '/' + resourceId.toString());
  print(availableQuantity);
  print(borrowedQuantity);
  print(quantity);

  return response.body;
}

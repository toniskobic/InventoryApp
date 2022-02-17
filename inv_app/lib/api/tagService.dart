import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:inv_app/Assets/constants.dart';
import 'package:inv_app/Classes/tag.dart';

final token =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NDIsImlhdCI6MTY0NDU5NDQ4OCwiZXhwIjoxNjQ3MTg2NDg4fQ.zFcK32mueZp7zYdjaCATqp6FtJ_MF_fxMsdSeyVbZFo';
final header = {
  'Content-Type': 'application/json',
  'Accept': 'application/json',
  'Authorization': 'Bearer $token'
};

List<Tag> parseTag(String responseBody) {
  final list = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return list.map<Tag>((json) => Tag.fromJson(json)).toList();
}

Future<List<Tag>> getTags() async {
  final response = await http.get(
    Uri.parse(TAGS),
    headers: header,
  );

  if (response.statusCode == 200)
    return parseTag(response.body);
  else
    return [];
}

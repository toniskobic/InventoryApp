import 'package:inv_app/Classes/resource.dart';
import 'package:inv_app/Classes/user.dart';

class Borrowed {
  int id;
  Resource resource;
  User user;
  String? dateFrom;
  String? dateTo;
  bool? status;
  String? created_at;
  String? updated_at;

  Borrowed({
    required this.id,
    required this.resource,
    required this.user,
    this.dateFrom,
    this.dateTo,
    this.status,
    this.created_at,
    this.updated_at,
  });

  factory Borrowed.fromJson(Map<String, dynamic> data) {
    return Borrowed(
      id: data['id'],
      resource: Resource.fromJson(data['resource']),
      user: User.fromJson(data['user']),
      dateFrom: data['dateFrom'],
      dateTo: data['dateTo'],
      status: data['status'],
      created_at: data['created_at'],
      updated_at: data['updated_at'],
    );
  }
}

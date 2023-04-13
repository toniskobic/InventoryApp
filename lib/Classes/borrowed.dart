import 'package:inv_app/Classes/resourceB.dart';
import 'package:inv_app/Classes/user.dart';

class Borrowed {
  int id;
  ResourceB? resource;
  User? user;
  String? dateFrom;
  String? dateTo;
  bool? status;
  String? created_at;
  String? updated_at;
  int? Quantity;

  Borrowed(
      {required this.id,
      this.resource,
      this.user,
      this.dateFrom,
      this.dateTo,
      this.status,
      this.created_at,
      this.updated_at,
      this.Quantity});

  factory Borrowed.fromJson(Map<String, dynamic> data) {
    return Borrowed(
      id: data['id'],
      resource: ResourceB.fromJson(data['resource']),
      user: User.fromJson(data['user']),
      dateFrom: data['dateFrom'],
      dateTo: data['dateTo'],
      status: data['status'],
      created_at: data['created_at'],
      updated_at: data['updated_at'],
      Quantity: data['Quantity'],
    );
  }
}

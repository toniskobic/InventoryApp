import 'package:inv_app/Classes/location.dart';
import 'package:inv_app/Classes/tag.dart';

class Resource {
  int id;
  String? name;
  String? description;
  int? quantity;
  String? status;
  Location? location;
  List<Tag>? tags;
  List<dynamic>? details;

  Resource(
      {required this.id,
      this.name,
      this.description,
      this.quantity,
      this.status,
      this.location,
      this.tags,
      this.details});

  factory Resource.fromJson(Map<String, dynamic> data) {
    return Resource(
      id: data['id'],
      name: data['name'],
      description: data['description'],
      quantity: data['quantity'],
      status: data['status'],
      //nedostajala je lokacija i odmah crklo
      location:
          data['location'] != null ? Location.fromJson(data['location']) : null,
      tags: List<Tag>.from(data['tags'].map((tag) => Tag.fromJson(tag))),
      details: data['Details'] != null ? data['Details'] : null,
    );
  }
}

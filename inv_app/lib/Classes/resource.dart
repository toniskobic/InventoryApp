import 'package:inv_app/Classes/location.dart';
import 'package:inv_app/Classes/tag.dart';
import 'package:inv_app/Classes/type.dart';

class Resource {
  int? id;
  String? name;
  String? description;
  int? quantity;
  /* Location? location;
  Type? type;
  Tag? tags; */
  Resource({
    this.id,
    this.name,
    this.description,
    this.quantity,
    /* this.location,
      this.type,
      this.tags */
  });

  factory Resource.fromJson(Map<String, dynamic> parsedJson) {
    return Resource(
      id: parsedJson['id'],
      name: parsedJson['name'],
      description: parsedJson['description'],
      quantity: parsedJson['quantity'],
      /* location: parsedJson['location'],
        type: parsedJson['type'],
        tags: parsedJson['tags'] */
    );
  }
}

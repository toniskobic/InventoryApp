import 'package:inv_app/Classes/location.dart';
import 'package:inv_app/Classes/picture.dart';
import 'package:inv_app/Classes/tag.dart';

class ResourceB {
  int id;
  String? name;
  String? description;
  int? quantity;
  Picture? picture;
  List<dynamic>? details;

  ResourceB(
      {required this.id,
      this.name,
      this.description,
      this.quantity,
      this.picture,
      this.details});

  factory ResourceB.fromJson(Map<String, dynamic> data) {
    return ResourceB(
        id: data['id'],
        name: data['name'],
        description: data['description'],
        quantity: data['quantity'],
        picture:
            data['Picture'] != null ? Picture.fromJson(data['Picture']) : null,
        details: data['Details'] != null ? data['Details'] : null);
  }
}

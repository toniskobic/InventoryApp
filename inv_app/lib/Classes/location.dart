class Location {
  int? id;
  String? name;
  String? description;
  int? quantity;

  Location({
    this.name,
    this.description,
    this.quantity,
  });

  factory Location.fromJson(Map<String, dynamic> parsedJson) {
    return Location(
        name: parsedJson['name'],
        description: parsedJson['description'],
        quantity: parsedJson['quantity']);
  }
}

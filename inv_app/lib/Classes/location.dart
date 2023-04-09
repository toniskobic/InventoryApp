class Location {
  int? id;
  String? name;
  String? coordinates;

  Location({
    this.id,
    this.name,
    this.coordinates,
  });

  factory Location.fromJson(Map<String, dynamic> parsedJson) {
    return Location(
        id: parsedJson['id'],
        name: parsedJson['name'],
        coordinates: parsedJson['coordinates']);
  }
}

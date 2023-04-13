class Type {
  int? id;
  String? name;

  Type({
    this.name,
  });

  factory Type.fromJson(Map<String, dynamic> parsedJson) {
    return Type(name: parsedJson['name']);
  }
}

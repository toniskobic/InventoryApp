class Tag {
  int? id;
  String? name;

  Tag({this.id, this.name});

  factory Tag.fromJson(Map<String, dynamic> data) {
    return Tag(id: data['id'], name: data['name']);
  }
}

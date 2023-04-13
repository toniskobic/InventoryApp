class User {
  String? name;
  String? surname;
  String? username;
  String? email;
  String? password;
  User({this.name, this.surname, this.username, this.email, this.password});

  factory User.fromJson(Map<String, dynamic> parsedJson) {
    return User(
        name: parsedJson['name'],
        surname: parsedJson['surname'],
        username: parsedJson['username'],
        email: parsedJson['email'],
        password: parsedJson['password']);
  }
}

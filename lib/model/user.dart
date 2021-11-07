class User {
  int id;
  String name;
  String username;
  String email;

  User.fromJson(Map json)
      : id = json['id'],
        name = json['name'],
        username = json['username'],
        email = json['email'];

  Map toJson() {
    return {'id': id, 'name': name, 'username': username, 'email': email};
  }
}

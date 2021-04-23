import '../utils/Connection.dart' as connection;

class User {
  int id;
  String name;
  String email;

  User({int id, String name, String email}) {
    this.id = id;
    this.name = name;
    this.email = email;
  }

  static Future<List<User>> all() async {
    var t = await connection.queryAll('select * from users');
    return t
        .map(
            (e) => User(id: e.values[0], name: e.values[1], email: e.values[2]))
        .toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
    };
  }
}

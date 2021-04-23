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

  static Future create({String name, String email}) async {
    return await connection.queryServer(
        'insert into users (name, email) values (?, ?)',
        values: [name, email]);
  }

  static Future<User> read({int id}) async {
    var result = (await connection
            .queryServer('select * from users where id = ?', values: [id]))
        .first;
    return User(
        id: result.values[0], name: result.values[1], email: result.values[2]);
  }

  static Future update({int id, String name, String email}) async {
    await connection.queryServer(
        'update users set name = ?, email = ? where id = ?',
        values: [name, email, id]);
  }

  static Future delete({int id}) async {
    await connection
        .queryServer('delete from users where id = ?', values: [id]);
  }

  static Future<List<User>> all() async {
    var result = await connection.queryServer('select * from users');
    return result
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

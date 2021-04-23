import 'dart:io';
import 'package:mysql1/mysql1.dart';

var settings = ConnectionSettings(
    host: 'localhost', port: 3306, user: 'root', password: null, db: 'dart');

Future<Results> queryServer(String query, {List<Object> values}) async {
  var conn = await MySqlConnection.connect(settings);
  var results = await conn.query(query, values);
  stdout.writeln('Results: ${results.toString()}');
  await conn.close();
  return results;
}

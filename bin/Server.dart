import 'dart:convert';
import 'dart:io';

import 'package:mysql1/mysql1.dart';

import 'controller/UserController.dart';
import 'exceptions/ActionNotFoundException.dart';
import 'exceptions/ResourceNotFoundException copy.dart';

Future setup() async {
  var server = await HttpServer.bind('0.0.0.0', 4007);
  stdout.writeln('Listening on port ${server.port}');
  await for (HttpRequest request in server) {
    await requestHandler(request);
  }
}

Future requestHandler(HttpRequest request) async {
  try {
    request.response.headers.contentType = ContentType.json;
    request.response.headers.add('Access-Control-Allow-Origin', '*');
    request.response.headers.add('Access-Control-Allow-Headers', '*');
    request.response.headers.add('Access-Control-Allow-Methods', 'GET');

    if (request.uri.pathSegments.isEmpty) throw ResourceNotFoundException();
    if (request.uri.pathSegments.length < 2) throw ActionNotFoundException();

    var resource = request.uri.pathSegments[0];
    var action = request.uri.pathSegments[1];

    switch (resource) {
      case 'user':
        await UserController.use(action, request);
        break;
      default:
        throw ResourceNotFoundException();
        break;
    }
  } catch (e) {
    if (e is MySqlException) {
      request.response.statusCode = 500;
      request.response.write(jsonEncode({
        'message': e.errorNumber,
        'errorNumber': e.message,
        'sqlState': e.sqlState,
      }));
    } else if (e is ActionNotFoundException || e is ResourceNotFoundException) {
      request.response.statusCode = 400;
      request.response.write(jsonEncode(e));
    } else {
      request.response.statusCode = 500;
      request.response.write(jsonEncode({
        'message': e.toString(),
      }));
    }
  } finally {
    await request.response.close();
  }
}

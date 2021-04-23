import 'dart:convert';
import 'dart:io';

import 'controller/UserController.dart';
import 'exceptions/ActionNotFoundException.dart';
import 'exceptions/ResourceNotFoundException copy.dart';

Future setup() async {
  var server = await HttpServer.bind(InternetAddress.loopbackIPv4, 4005);
  stdout.writeln('Listening on port ${server.port}');
  await for (HttpRequest request in server) {
    await requestHandler(request);
  }
}

Future requestHandler(HttpRequest request) async {
  try {
    request.response.headers.contentType = ContentType.json;

    if (request.uri.pathSegments.isEmpty) throw ResourceNotFoundException();
    if (request.uri.pathSegments.length < 2) throw ActionNotFoundException();

    var resource = request.uri.pathSegments[0];
    var action = request.uri.pathSegments[1];

    stdout.writeln(resource);

    switch (resource) {
      case 'user':
        await UserController.use(action, request);
        break;
      default:
        throw ResourceNotFoundException();
        break;
    }
  } catch (e) {
    request.response.statusCode = 400;
    request.response.write(jsonEncode(e));
  } finally {
    await request.response.close();
  }
}

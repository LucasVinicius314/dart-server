import 'dart:convert';
import 'dart:io';

import '../exceptions/ActionNotFoundException.dart';
import '../model/User.dart';
import '../responses/ResourceCreatedResponse.dart';
import '../responses/ResourceDeletedResponse.dart';
import '../responses/ResourceUpdatedResponse.dart';

class UserController {
  static Future use(String action, HttpRequest request) async {
    switch (action) {
      case 'all':
        await all(request);
        break;
      case 'create':
        await create(request);
        break;
      case 'read':
        await read(request);
        break;
      case 'update':
        await update(request);
        break;
      case 'delete':
        await delete(request);
        break;
      default:
        throw ActionNotFoundException();
        break;
    }
  }

  static Future create(HttpRequest request) async {
    var name = request.uri.queryParameters['name'];
    var email = request.uri.queryParameters['email'];
    await User.create(name: name, email: email);
    request.response.write(jsonEncode(ResourceCreatedResponse('User')));
  }

  static Future read(HttpRequest request) async {
    var id = int.parse(request.uri.queryParameters['id']);
    var user = await User.read(id: id);
    request.response.write(jsonEncode(user));
  }

  static Future update(HttpRequest request) async {
    var id = int.parse(request.uri.queryParameters['id']);
    var name = request.uri.queryParameters['name'];
    var email = request.uri.queryParameters['email'];
    await User.update(id: id, email: email, name: name);
    request.response.write(jsonEncode(ResourceUpdatedResponse('User')));
  }

  static Future delete(HttpRequest request) async {
    var id = int.parse(request.uri.queryParameters['id']);
    await User.delete(id: id);
    request.response.write(jsonEncode(ResourceDeletedResponse('User')));
  }

  static Future all(HttpRequest request) async {
    var users = await User.all();
    request.response.write(jsonEncode(users));
  }
}

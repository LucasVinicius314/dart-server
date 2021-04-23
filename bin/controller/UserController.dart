import 'dart:convert';
import 'dart:io';

import '../exceptions/ActionNotFoundException.dart';
import '../model/User.dart';

class UserController {
  static Future use(String action, HttpRequest request) async {
    switch (action) {
      case 'all':
        await all(request);
        break;
      default:
        throw ActionNotFoundException();
        break;
    }
  }

  static Future all(HttpRequest request) async {
    var users = await User.all();
    request.response.write(jsonEncode(users));
  }
}

class ActionNotFoundException implements Exception {
  Map<String, dynamic> toJson() {
    return {
      'message':
          'Action not found or invalid. If missing, try adding an action to the uri. Example: /resource/action'
    };
  }
}

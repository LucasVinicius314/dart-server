class ResourceNotFoundException implements Exception {
  Map<String, dynamic> toJson() {
    return {
      'message':
          'Resource not found or invalid. If missing, try adding a resource to the uri. Example: /resource'
    };
  }
}

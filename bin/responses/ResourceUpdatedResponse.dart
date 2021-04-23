class ResourceUpdatedResponse {
  String type;

  ResourceUpdatedResponse(String type) {
    this.type = type;
  }

  Map<String, dynamic> toJson() {
    return {'message': '$type updated.'};
  }
}

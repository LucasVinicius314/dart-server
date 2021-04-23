class ResourceCreatedResponse {
  String type;

  ResourceCreatedResponse(String type) {
    this.type = type;
  }

  Map<String, dynamic> toJson() {
    return {'message': '$type created.'};
  }
}

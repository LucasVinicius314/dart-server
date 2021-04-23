class ResourceDeletedResponse {
  String type;

  ResourceDeletedResponse(String type) {
    this.type = type;
  }

  Map<String, dynamic> toJson() {
    return {'message': '$type deleted.'};
  }
}

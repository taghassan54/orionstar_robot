class MethodHandlerResponse {
  MethodHandlerResponse({
      this.type, 
      this.status, 
      this.data,});

  MethodHandlerResponse.fromJson(dynamic json) {
    type = json['type'];
    status = json['status'];
    data = json['data'];
  }
  String type;
  String status;
  String data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = type;
    map['status'] = status;
    map['data'] = data;
    return map;
  }

}
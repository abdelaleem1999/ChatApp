class HomeModelsMessage {
  HomeModelsMessage({
    this.sender,
    this.message,
  });
  String? sender;
  String? message;

  HomeModelsMessage.fromJson(Map<dynamic, dynamic> json) {
    sender = json["sender"] ?? "";
    message = json["message"] ?? "";
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['sender'] = sender;
    _data['message'] = message;
    return _data;
  }
}

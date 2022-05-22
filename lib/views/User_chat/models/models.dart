class HomeModels {
  HomeModels({
    this.name,
    this.email,
  });
  String? name;
  String? email;

  HomeModels.fromJson(Map<dynamic, dynamic> json) {
    name = json["name"] ?? "";
    email = json["email"] ?? "";
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['email'] = email;
    return _data;
  }
}

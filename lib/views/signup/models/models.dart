class HomeModel {
  HomeModel({
    this.name,
    this.email,
    this.pass,
  });
  String? name;
  String? email;
  String? pass;

  HomeModel.fromJson(Map<dynamic, dynamic> json) {
    name = json["name"] ?? "";
    email = json["email"] ?? "";
    pass = json["pass"] ?? "";
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['email'] = email;
    _data['pass'] = pass;
    return _data;
  }
}

class UserModel {
  final String id;
  final String name;
  final String email;
  final String password;

  UserModel(
      {required this.id,
      required this.name,
      required this.email,
      required this.password});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final id = json['id'];
    final name = json['name'];
    final email = json['email'];
    final password = json['password'];
    return UserModel(id: id, name: name, email: email, password: password);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['password'] = password;
    return data;
  }
}


class UserModel {
  String id;
  String name;
  String phone;
  String email;
  String address;
  UserModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.address,
    required this.email,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      'name': name,
      "phone": phone,
      "address": address,
      "email": email,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id:  map["id"],
      name:  map["name"],
      phone:  map["phoe"],
      address:  map["address"],
      email:  map["email"],
    );
  }
}

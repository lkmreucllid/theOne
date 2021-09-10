import 'dart:convert';

User userFromJson(String str) {
  final jsonData = json.decode(str);
  return User.fromJson(jsonData);
}

String userToJson(User data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

List<User> allUsersFromAPI(String str) {
  final jsonData = json.decode(str);
  return new List<User>.from(jsonData.map((x) => User.fromJson(x)));
}

String allUsersToJson(List<User> data) {
  final dyn = new List<dynamic>.from(data.map((x) => x.toJson()));
  return json.encode(dyn);
}

class User {
  String id;
  String name;
  String email;
  String country;
  String address;
  String contact;
  String gender;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.country,
    required this.address,
    required this.contact,
    required this.gender,
  });

  factory User.fromJson(Map<String, dynamic> json) => new User(
      id: json["_id"],
      name: json["name"],
      email: json["email"],
      country: json["country"],
      address: json["address"],
      contact: json["contact"],
      gender: json["gender"]);

  factory User.fromDB(Map<String, dynamic> json) => new User(
      id: json["id"],
      name: json["name"],
      email: json["email"],
      country: json["country"],
      address: json["address"],
      contact: json["contact"],
      gender: json["gender"]);

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "email": email,
        "country": country,
        "address": address,
        "contact": contact,
        "gender": gender,
      };

  Map<String, dynamic> toDB() => {
        "id": id,
        "name": name,
        "email": email,
        "country": country,
        "address": address,
        "contact": contact,
        "gender": gender,
      };
}

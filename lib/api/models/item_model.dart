class ItemModel {
  final int id;
  final String name;
  final String email;
  final String country;
  final String address;
  final String contact;
  final String gender;

  ItemModel.fromJSON(Map<String, dynamic> parsedJson)
      : id = parsedJson["id"],
        name = parsedJson["name"],
        email = parsedJson["email"],
        country = parsedJson["country"],
        address = parsedJson["address"],
        contact = parsedJson["contct"],
        gender = parsedJson["gender"];
}

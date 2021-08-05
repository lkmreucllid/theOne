import 'package:http/http.dart' as client;
import 'dart:convert';
import '../models/item_model.dart';

final _root =
    "https://user-registration-test-pawan.herokuapp.com/user?name&contact=";

class ItemProvider {
  Future<ItemModel> fetchItem(
      String name, String contact, String bearer) async {
    final response =
        await client.get(Uri.parse('$_root?name=$name&contacr=$contact'));
    final parsedJson = json.decode(response.body);

    return ItemModel.fromJSON(parsedJson);
  }
}

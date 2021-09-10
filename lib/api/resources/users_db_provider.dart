import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:theOne/api/resources/users_api_provider.dart';
import 'dart:async';
import '../models/user_model.dart';
import 'package:sqflite/sqflite.dart';

class UserDbProvider {
  UserDbProvider() {
    init();
  }

  init() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, "user.db");
    Database db = await openDatabase(
      path,
      version: 2,
      onCreate: (Database newDb, int version) {
        newDb.execute("""
        CREATE TABLE Users(
          id TEXT,
          name TEXT,
          country TEXT,
          address TEXT,
          contact TEXT,
          gender TEXT,
          email TEXT
        )
        """);
      },
    );
    return db;
  }

  Future<int> addIntoDb(User user) async {
    Database db = await init();
    return db.insert("Users", user.toDB(),
        conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  Future<List<User>?> fetchAllUsers(
      String? nameFilter, String? contactFilter, BuildContext context) async {
    Database db = await init();
    print('Called DB');
    final List<Map<String, dynamic>> maps = await db.query("Users",
        columns: null,
        where: "name like ? and contact like ?",
        whereArgs: ['%$nameFilter%', '%$contactFilter%']);

    if (maps.length > 0) {
      // return allUsersFromDb(jsonEncode(maps));
      return List.generate(maps.length, (index) {
        return User(
          id: maps[index]['id'],
          name: maps[index]['name'],
          email: maps[index]['email'],
          country: maps[index]['country'],
          address: maps[index]['address'],
          contact: maps[index]['contact'],
          gender: maps[index]['gender'],
        );
      });
    }
    final List<Map<String, dynamic>> allUsers = await db.query("Users");

    if (allUsers.length == 0) {
      UserApiProvider userApiProvider = UserApiProvider();
      await userApiProvider.fetchAllUsers(nameFilter, contactFilter, context);
    }
    return null;
  }

  Future<User?> fetchUserDetail(String emailFilter) async {
    Database db = await init();
    print('Called DB for single User');
    final List<Map<String, dynamic>> maps = await db.query("Users",
        columns: null,
        where: "lower(email) = ?",
        whereArgs: ['${emailFilter.toLowerCase()}']);

    if (maps.length > 0) {
      // return allUsersFromDb(jsonEncode(maps));

      return User(
        id: maps.first['id'],
        name: maps.first['name'],
        email: maps.first['email'],
        country: maps.first['country'],
        address: maps.first['address'],
        contact: maps.first['contact'],
        gender: maps.first['gender'],
      );
    }
    return null;
  }

  Future<int> clear() async {
    Database db = await init();
    return db.delete("Users");
  }
}

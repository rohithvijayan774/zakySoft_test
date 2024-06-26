import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zakysoft_test/const/const.dart';
import 'package:zakysoft_test/model/updated_user_model.dart';
import 'package:zakysoft_test/model/user_model.dart';
import 'package:zakysoft_test/services/database_helper.dart';
import 'package:zakysoft_test/view/users_list.dart';

class UserController with ChangeNotifier {
  DataBaseHelper databaseHelper = DataBaseHelper();

  List<UserModel> users = [];

  Future<List<UserModel>> fetchUsers() async {
    try {
      final response = await http.get(Uri.parse(api));
      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.decode(response.body);
        print(response.body);

        users = jsonResponse.map((json) => UserModel.fromJson(json)).toList();

        for (var user in users) {
          await insertUser(user);
          await getUsers();
        }

        return users;
      } else {
        throw Exception("Status Code : : : ${response.statusCode}");
      }
    } catch (e) {
      throw Exception('Something Went Wrong!!! $e');
    }
  }

  Future<int> insertUser(UserModel user) async {
    try {
      var dbClient = DataBaseHelper.db;
      var result = await dbClient!.insert('users', user.toJson());
      return result;
    } catch (e) {
      throw Exception('FAILED TO STORE TO DB : : : $e');
    }
  }

  List<UpdatedUserModel> usersList = [];

  Future<List<UserModel>> getUsers() async {
    var dbClient = DataBaseHelper.db;
    List<Map<String, dynamic>> maps = await dbClient!.query('users');
    if (maps.isNotEmpty) {
      usersList.clear();
      results.clear();
      for (var i = 0; i < maps.length; i++) {
        print(maps);
        usersList.add(UpdatedUserModel.fromJson(maps[i]));
        results = usersList;
      }
    } else {
      print('List is empty XXXXXXXXXXXXXXXXXXXX');

      await fetchUsers();
    }
    return users;
  }

  List<UpdatedUserModel> results = [];

  void searchUser(String searchText) {
    if (searchText.isEmpty) {
      results.clear();
      results.addAll(usersList);
    } else {
      results = usersList.where((user) {
        return user.name!.toLowerCase().contains(searchText.toLowerCase()) ||
            user.email!.toLowerCase().contains(searchText.toLowerCase());
      }).toList();
    }

    notifyListeners();
  }

  //-------------- Splash Screen -----------------------------

  Future splashScreenLoader(context) async {
    await _checkLocationPermission();
    await Future.delayed(const Duration(seconds: 3));
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const UsersList(),
        ),
        (route) => false);
  }

  //--------------- Location Permission -----------------------

  PermissionStatus _permissionStatus = PermissionStatus.denied;

  Future<void> _checkLocationPermission() async {
    PermissionStatus permission = await Permission.location.status;
    _permissionStatus = permission;

    if (_permissionStatus.isDenied) {
      PermissionStatus permissionStatus = await Permission.location.request();
      _permissionStatus = permissionStatus;
    }
    notifyListeners();
  }

  Future<void> launchGoogleMap(double latitude, double longitude) async {
    String googleMapsUrl = '$googleMapApi$latitude,$longitude';
    if (!await launchUrl(Uri.parse(googleMapsUrl))) {
      throw Exception('Could not launch ${Uri.parse(googleMapsUrl)}');
    }
  }
}

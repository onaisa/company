import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class StorageUtil {
  static final StorageUtil _storageUtil = StorageUtil._internal();

  factory StorageUtil.getInstance() {
    return _storageUtil;
  }

  StorageUtil._internal();

  void storeAuth() async {
    SharedPreferences _sharedPref = await SharedPreferences.getInstance();
    // _sharedPref.setString('usermodel', jsonEncode(data));
    _sharedPref.setString('initRoute', '/profile');
  }

  Future<String> initRoute() async {
    SharedPreferences _sharedPref = await SharedPreferences.getInstance();
    return _sharedPref.getString('initRoute') ?? '/splashcreen';
  }

  void clean() async {
    SharedPreferences _sharedPref = await SharedPreferences.getInstance();
    _sharedPref.clear();
  }

  // Future<dynamic> getAuth() async {
  //   SharedPreferences _sharedPref = await SharedPreferences.getInstance();
  //   return jsonDecode(_sharedPref.get('usermodel'));
  // }

  Future<dynamic> getauth() async {
    SharedPreferences _sharedPref = await SharedPreferences.getInstance();
    var s = jsonDecode(_sharedPref.get('usermodel'));
    print(s);
    return s;
  }
}

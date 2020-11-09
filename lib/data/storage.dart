import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Store {

  static Future<void> saveString(String key, String value)async{
   final prefs = await SharedPreferences.getInstance();
   prefs.setString(key, value);
  }

  static Future<void> saveMap(String key, Map<String,dynamic>value)async{

    saveString(key, json.encode(value));
  }
  static Future<String> getString(String key)async{
    final pref =await SharedPreferences.getInstance();
    return pref.getString(key);
  }
  static Future<Map<String,dynamic>> getMap(String key)async{
    try{
      Map<String,dynamic> map = await json.decode(await getString(key));
      return map;
    } catch(e){
      return null;
    }
  }

  static Future<bool> remove(String key)async{
    final pref =await SharedPreferences.getInstance();
    return pref.remove(key);
  }
}
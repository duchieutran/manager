import 'dart:convert';

import 'package:appdemo/models/model_user.dart';
import 'package:appdemo/services/api_service/home_sevice.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeProvider with ChangeNotifier {
  //seach
  TextEditingController searchController = TextEditingController();
  List<ModelUser> filter = [];
  String key = 'id';
  List<String> fillerTitle = ['ID', 'Name', 'Address', 'Age', 'Email'];
  // edit
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  // search
  List<ModelUser> users = [];
  bool checkData = false;
  bool _loading = true;

  // get and init data
  void setLoading(bool a) {
    _loading = a;
    notifyListeners();
  }

  // get loading
  getLoading() => _loading;

  // get data
  Future<void> getData({String? key, String? value}) async {
    try {
      List<ModelUser> tmp;
      if (key != null && value != null) {
        tmp = await HomeService().getData(key: key, onValue: value);
      } else {
        tmp = await HomeService().getData();
      }
      users = tmp;
      // await saveUser(users);
      checkData = true;
      _loading = false;
      notifyListeners();
    } catch (e) {
      checkData = false;
      _loading = false;
      notifyListeners();
    }
  }

  // lưu dữ liệu vào bộ nhớ
  Future<void> saveUser(List<ModelUser> user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final users = jsonEncode(user);
    await prefs.setString('user', users);
  }

  // đọc dữ liệu từ bộ nhớ
  Future<List<Map<String, dynamic>>> loadUserList() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // Đọc chuỗi JSON từ SharedPreferences
    String? userListJson = prefs.getString('userList');
    if (userListJson != null) {
      // Chuyển đổi chuỗi JSON thành danh sách Map<String, dynamic>
      List<dynamic> userListDynamic = jsonDecode(userListJson);
      List<Map<String, dynamic>> userList =
          userListDynamic.cast<Map<String, dynamic>>();
      return userList;
    } else {
      return [];
    }
  }

  // delete data
  Future<void> deletaData({required ModelUser user}) async {
    users.remove(user);
    notifyListeners();
    try {
      await HomeService().deteleData(user.id);
      checkData = true;
    } catch (e) {
      users.add(user);
      checkData = false;
    }
    notifyListeners();
  }

  // set key
  setKey(String value) {
    key = value;
    notifyListeners();
  }
}

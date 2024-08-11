// import 'dart:convert';

// import 'package:appdemo/models/model_user.dart';
// import 'package:appdemo/services/api_service/home_sevice.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class HomeProvider with ChangeNotifier {
//   //seach
  
//   List<ModelUser> filter = [];
//   String key = 'id';
//   List<String> fillerTitle = ['ID', 'Name', 'Address', 'Age', 'Email'];
//   // edit
//   TextEditingController nameController = TextEditingController();
//   TextEditingController emailController = TextEditingController();
//   TextEditingController addressController = TextEditingController();
//   TextEditingController imageController = TextEditingController();
//   TextEditingController ageController = TextEditingController();
//   // search



//   // get data
//   Future<void> getData({String? key, String? value}) async {
//     try {
//       List<ModelUser> tmp;
//       if (key != null && value != null) {
//         tmp = await HomeService().getData(key: key, onValue: value);
//       } else {
//         tmp = await HomeService().getData();
//       }
//       users = tmp;
//       await saveUser(users);
//       _loading = false;
//       notifyListeners();
//     } catch (e) {
//       users = await loadUserList();
//       _loading = false;
//       notifyListeners();
//     }
//   }

//   // lưu dữ liệu vào bộ nhớ
//   Future<void> saveUser(List<ModelUser> users) async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     final String usersJson = jsonEncode(users.map((e) => e.toJSON()).toList());
//     await prefs.setString('userList', usersJson);
//   }

//   // đọc dữ liệu từ bộ nhớ
//   Future<List<ModelUser>> loadUserList() async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     // Đọc chuỗi JSON từ SharedPreferences
//     String? userListJson = prefs.getString('userList');
//     if (userListJson != null) {
//       // chuyển JSON thành Map
//       List<dynamic> userListDynamic = jsonDecode(userListJson);
//       List<ModelUser> userList =
//           userListDynamic.map((e) => ModelUser.fromJSON(e)).toList();
//       return userList;
//     } else {
//       return [];
//     }
//   }

//   // delete data
//   Future<void> deleteData({required ModelUser user}) async {
//     users.remove(user);
//     notifyListeners();
//     try {
//       await HomeService().deleteData(user.id);
//       checkData = true;
//     } catch (e) {
//       users.add(user);
//       checkData = false;
//     }
//     notifyListeners();
//   }

//   // set key
//   setKey(String value) {
//     key = value;
//     notifyListeners();
//   }
// }

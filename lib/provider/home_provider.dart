import 'package:appdemo/models/model_user.dart';
import 'package:appdemo/services/api_service/home_sevice.dart';
import 'package:flutter/material.dart';

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

  getLoading() => _loading;

  Future<void> getData() async {
    try {
      List<ModelUser> tmp = await HomeService().getData();
      users = tmp;
      checkData = true;
      _loading = false;
      notifyListeners();
    } catch (e) {
      checkData = false;
      _loading = false;
      notifyListeners();
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

  // search data
  Future<void> searchShowInfo(String key, String value) async {
    try {
      final List<ModelUser> tmp = await HomeService().searchData(key, value);
      users = tmp;
      checkData = true;
      _loading = false;
      notifyListeners();
    } catch (e) {
      users = [];
      checkData = false;
      _loading = false;
      notifyListeners();
    }
  }

  setKey(String value) {
    key = value;
    notifyListeners();
  }
}

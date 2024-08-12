import 'dart:convert';

import 'package:appdemo/models/model_user.dart';
import 'package:appdemo/services/api_service/home_sevice.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'home_store.g.dart';

class HomeStore = HomeStoreBase with _$HomeStore;

abstract class HomeStoreBase with Store {
  @observable
  List<ModelUser> users = [];
  @observable
  bool isLoading = true;
  @observable
  bool _isRemove = false;
  @observable
  String _key = 'id';

  @action
  void setIsLoading(bool a) {
    isLoading = a;
  }

  @action
  void callSetIsLoading(bool a) {
    setIsLoading(a);
  }

  // get _isRemove
  @action
  bool getIsRemove() => _isRemove;

  // set key
  @action
  void setKey(String value) {
    runInAction(() {
      _key = value;
    });
  }

  @action
  void callSetKey(String value) {
    setKey(value);
  }

  // get key
  @action
  String getKey() => _key;

// Các phương thức
  // Phương thức lấy dữ liệu
  @action
  Future<void> _getData({String? key, String? value}) async {
    try {
      List<ModelUser> tmp;
      if (key != null || value != null) {
        tmp = await HomeService().getData(key: key, onValue: value);
      } else {
        tmp = await HomeService().getData();
      }
      users.addAll(tmp);
      await _saveUser(users);
      isLoading = false;
    } catch (e) {
      await _loadUserList();
      isLoading = false;
    }
  }

  // lưu dữ liệu vào bộ nhớ
  @action
  Future<void> _saveUser(List<ModelUser> users) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String usersJson = jsonEncode(users.map((e) => e.toJSON()).toList());
    await prefs.setString('userList', usersJson);
  }

  // đọc dữ liệu từ bộ nhớ
  @action
  Future<List<ModelUser>> _loadUserList() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance(); // TODO : refactor
    // Đọc chuỗi JSON từ SharedPreferences
    String? userListJson = prefs.getString('userList');
    if (userListJson != null) {
      // chuyển JSON thành Map
      List<dynamic> userListDynamic = jsonDecode(userListJson);
      List<ModelUser> userList =
          userListDynamic.map((e) => ModelUser.fromJSON(e)).toList();
      return userList;
    } else {
      return [];
    }
  }

  @action
  Future<void> callGetData({String? key, String? value}) async {
    await _getData(key: key, value: value);
  }

  // phương thức xoá
  @action
  Future<void> _removeData({required ModelUser user}) async {
    users.remove(user);
    try {
      HomeService().deleteData(user.id);
      _isRemove = true;
    } catch (e) {
      _isRemove = false;
      users.add(user);
    }
  }

  @action
  Future<void> callRemoveData({required ModelUser user}) async {
    await _removeData(user: user);
  }
}

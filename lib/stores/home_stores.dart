import 'dart:convert';

import 'package:appdemo/models/model_user.dart';
import 'package:appdemo/services/api_service/home_sevice.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:mobx/mobx.dart';

class HomeStores {
  // Observable
  ObservableList<ModelUser> users = ObservableList<ModelUser>();
  Observable<bool> _isLoading =
      Observable(true); // dùng để load khi tải dữ liệu
  final Observable<bool> _isRemove =
      Observable(false); // dùng để ktra xoá thành công chưa
  final Observable<String> _key = Observable('id');

  // Actions
  late Action setIsloadingAction;
  late Action setKeyAction;

  HomeStores() {
    setIsloadingAction = Action(callSetIsLoading);
    setKeyAction = Action(callSetKey);
  }

  // getter and setter

  // set _isLoading
  void setIsLoading(bool a) {
    runInAction(() {
      // TODO: cái này ảo thật đấy ?
      _isLoading.value = a;
    });
  }

  void callSetIsLoading(bool a) {
    setIsLoading(a);
  }

  // get _isLoading
  bool getIsloading() => _isLoading.value;

  // get _isRemove
  bool getIsRemove() => _isRemove.value;

  // set key
  @action
  void setKey(String value) {
    runInAction(() {
      _key.value = value;
    });
  }

  @action
  void callSetKey(String value) {
    setKey(value);
  }

  // get key
  String getKey() => _key.value;

// Các phương thức
  // Phương thức lấy dữ liệu
  Future<void> _getData({String? key, String? value}) async {
    try {
      List<ModelUser> tmp;
      if (key != null || value != null) {
        tmp = await HomeService().getData(key: key, onValue: value);
      } else {
        tmp = await HomeService().getData();
      }
      users.addAll(tmp);
      await saveUser(users);
      setIsLoading(false);
    } catch (e) {
      await loadUserList();
      setIsLoading(false);
    }
  }

  // lưu dữ liệu vào bộ nhớ
  Future<void> saveUser(List<ModelUser> users) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String usersJson = jsonEncode(users.map((e) => e.toJSON()).toList());
    await prefs.setString('userList', usersJson);
  }

  // đọc dữ liệu từ bộ nhớ
  Future<List<ModelUser>> loadUserList() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
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

  Future<void> callGetData({String? key, String? value}) async {
    await _getData(key: key, value: value);
  }

  // phương thức xoá
  Future<void> _removeData({required ModelUser user}) async {
    users.remove(user);
    try {
      HomeService().deleteData(user.id);
      _isRemove.value = true;
    } catch (e) {
      _isRemove.value = false;
      users.add(user);
    }
  }

  Future<void> callRemoveData({required ModelUser user}) async {
    await _removeData(user: user);
  }
}

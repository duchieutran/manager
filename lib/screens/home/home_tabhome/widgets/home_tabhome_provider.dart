import 'package:appdemo/global/api/api_error.dart';
import 'package:appdemo/models/model_user.dart';
import 'package:appdemo/services/api_service/home_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeTabhomeProvider extends ChangeNotifier {
  List<ModelUser> filteredUsers = [];
  bool checkGetData = true;
  String errorMess = "";

  Future<void> getData({required BuildContext context}) async {
    try {
      final List<ModelUser> tmp = await HomeService().getData();
      filteredUsers = tmp;
      checkGetData = false;
    } catch (e) {
      ApiError error = e as ApiError;
      checkGetData = false;
      errorMess = error.errorMessage.toString();
    }
    notifyListeners();
  }

  Future<bool> deleteData({required String id}) async {
    try {
      await HomeService().deteleData(id);
      return true;
    } catch (e) {
      return false;
    }
  }

  void deleteDataTmp(user) {
    filteredUsers.remove(user);
    notifyListeners();
  }

  void addDataTmp(user) {
    filteredUsers.add(user);
  }
}

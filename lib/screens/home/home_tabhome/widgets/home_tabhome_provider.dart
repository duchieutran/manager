import 'package:appdemo/global/api/api_error.dart';
import 'package:appdemo/models/model_user.dart';
import 'package:appdemo/screens/home/home_tabhome/widgets/home_tabhome_dialog.dart';
import 'package:appdemo/services/api_service/home_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeTabhomeProvider extends ChangeNotifier {
  List<ModelUser> filteredUsers = [];

  Future<void> getData({required BuildContext context}) async {
    try {
      final List<ModelUser> tmp = await HomeService().getData();
      filteredUsers = tmp;
      notifyListeners();
    } catch (e) {
      ApiError error = e as ApiError;
      _showCustomDialog(
          context: context,
          title: 'Message',
          content: error.errorMessage.toString());
    }
  }

  Future<bool> deletaData({required String id}) async {
    try {
      await HomeService().deteleData(id);
      return true;
    } catch (e) {
      return false;
    }
  }

  void _showCustomDialog({
    required BuildContext context,
    required String title,
    required String content,
  }) {
    HomeTabhomeDialog.showCustomDialog(
      context: context,
      title: title,
      content: content,
    );
  }
}

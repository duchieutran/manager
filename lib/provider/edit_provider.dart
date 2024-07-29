import 'package:appdemo/models/model_user.dart';
import 'package:appdemo/services/api_service/home_sevice.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EditProvider with ChangeNotifier {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController imageController = TextEditingController();
  final TextEditingController idController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  bool checkData = false;

  // default value
  defaultValueTextField(ModelUser user) {
    nameController.text = user.name;
    emailController.text = user.email;
    addressController.text = user.address;
    imageController.text = user.image;
    ageController.text = user.age.toString();
  }

  // check empty
  bool checkEmpty() {
    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        addressController.text.isEmpty ||
        imageController.text.isEmpty ||
        ageController.text.isEmpty ||
        int.tryParse(ageController.text) == null) {
      return true;
    } else {
      return false;
    }
  }

  // check url img
  Future<bool> loadImg() async {
    try {
      final response = await http.head(Uri.parse(imageController.text));
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  // edit data
  Future<void> updateData(String id) async {
    ModelUser userUpdate = ModelUser(
        id: id,
        name: nameController.text,
        age: int.tryParse(ageController.text) ?? 0,
        address: addressController.text,
        email: emailController.text,
        image: imageController.text);
    try {
      ModelUser user =
          await HomeService().updateData(userUpdate.id, userUpdate.toJSON());
      defaultValueTextField(user);
      checkData = true;
      notifyListeners();
    } catch (e) {
      checkData = false;
      notifyListeners();
    }
  }
}

import 'package:appdemo/models/model_user.dart';
import 'package:appdemo/services/api_service/home_sevice.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class AddProvider with ChangeNotifier {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController imageController = TextEditingController();
  final TextEditingController idController = TextEditingController();
  final TextEditingController ageController = TextEditingController();

  // check empty
  bool checkEmpty() {
    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        addressController.text.isEmpty ||
        imageController.text.isEmpty ||
        ageController.text.isEmpty ||
        int.tryParse(ageController.text) == null) {
      return false;
    } else {
      return true;
    }
  }

  // check img
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

  // post data
  Future<void> addUser() async {
    // neu khong can thiet phai dung den local thi khong can tao bien local
    ModelUser user = ModelUser(
      name: nameController.text,
      email: emailController.text,
      address: addressController.text,
      image: imageController.text,
      id: '',
      age: int.tryParse(ageController.text) ?? 0,
    );

    try {
      await HomeService().createData(user);
    } catch (e) {
      rethrow;
    }
  }
}

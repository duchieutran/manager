import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:appdemo/models/model_user.dart';
import 'package:appdemo/services/reponsitory/home_reponsitory.dart';

class HomeSevice extends HomeReponsitory {
  @override
  Future<ModelUser> createData(ModelUser user) async {
    try {
      final response = await http.post(
        Uri.parse(
            "https://66879a5f0bc7155dc0184943.mockapi.io/api/v1/users/user"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(user.toJSON()),
      );
      if (response.statusCode == 201) {
        return user;
      } else {
        throw Exception('Fail create data');
      }
    } catch (e) {
      throw UnimplementedError();
    }
  }

  @override
  Future<bool> deteleData(String id) async {
    try {
      final response = await http.delete(
        Uri.parse(
            "https://66879a5f0bc7155dc0184943.mockapi.io/api/v1/users/user/$id"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 200) {
        print('Delete success');
        return true;
      } else {
        print('Delete failed with status: ${response.statusCode}');
        throw Exception('Failed to delete user');
      }
    } catch (e) {
      throw UnimplementedError();
    }
  }

  @override
  Future<List<ModelUser>> getData() async {
    try {
      final response = await http.get(Uri.parse(
          'https://66879a5f0bc7155dc0184943.mockapi.io/api/v1/users/user'));
      if (response.statusCode == 200) {
        List data = await json.decode(response.body);
        List<ModelUser> users = data.map((e) => ModelUser.fromJSON(e)).toList();
        return users;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<List<ModelUser>> searchData() {
    // TODO: implement searchData
    throw UnimplementedError();
  }

  @override
  Future<ModelUser> updateData() {
    // TODO: implement updateData
    throw UnimplementedError();
  }
}

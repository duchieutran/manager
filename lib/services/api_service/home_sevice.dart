import 'dart:convert';
import 'package:appdemo/global/api/api_error.dart';
import 'package:appdemo/global/api/rest_client.dart';
import 'package:http/http.dart' as http;
import 'package:appdemo/models/model_user.dart';
import 'package:appdemo/services/reponsitory/home_reponsitory.dart';

class HomeService extends HomeReponsitory {
  final RestClient _dio =
      RestClient('https://66879a5f0bc7155dc0184943.mockapi.io/api/v1/users');

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
        return true;
      } else {
        throw Exception('Failed to delete user');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<ModelUser>> getData() async {
    try {
      final response = await _dio.get('/user');
      if (response is List<dynamic>) {
        final user = response;
        List<ModelUser> users = user.map((e) => ModelUser.fromJSON(e)).toList();
        return users;
      }
      throw ApiError.fromResponse(response);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<ModelUser>> searchData(String key, String value) async {
    final tmpValue = value.toLowerCase();
    try {
      final response = await _dio.get('/user', queryParameters: {key: value});
      List<dynamic> tmp = response.data;
      List<ModelUser> users = tmp
          .map((value) => ModelUser.fromJSON(value))
          .where((e) =>
              e.id.toLowerCase().contains(tmpValue) ||
              e.name.toLowerCase().contains(tmpValue) ||
              e.age.toString().contains(tmpValue) ||
              e.address.toLowerCase().contains(tmpValue) ||
              e.email.toLowerCase().contains(tmpValue))
          .toList();
      return users;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> updateData(String id, Map<String, dynamic> data) async {
    try {
      final response = await http.put(
          Uri.parse(
              'https://66879a5f0bc7155dc0184943.mockapi.io/api/v1/users/user/$id'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          },
          body: jsonEncode(data));
      if (response.statusCode == 200) {
        return true;
      } else {
        throw 'Fail !';
      }
    } catch (e) {
      rethrow;
    }
  }
}

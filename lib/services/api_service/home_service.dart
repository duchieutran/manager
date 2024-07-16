import 'package:dio/dio.dart';
import 'package:appdemo/models/model_user.dart';
import 'package:appdemo/services/reponsitory/home_reponsitory.dart';

class HomeService extends HomeReponsitory {
  final dio = Dio();
  @override
  Future<ModelUser> createData(ModelUser user) async {
    try {
      final response = await dio.post(
          "https://66879a5f0bc7155dc0184943.mockapi.io/api/v1/users/user",
          data: user.toJSON());
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
      final response = await dio.delete(
          "https://66879a5f0bc7155dc0184943.mockapi.io/api/v1/users/user/$id");
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
      final response = await dio
          .get('https://66879a5f0bc7155dc0184943.mockapi.io/api/v1/users/user');
      List<dynamic> tmp = response.data;

      if (response.statusCode == 200) {
        List<ModelUser> user =
            tmp.map((value) => ModelUser.fromJSON(value)).toList();
        return user;
      } else {
        throw 'Hello bug =))';
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<ModelUser>> searchData(String key, String value) async {
    final tmpValue = value.toLowerCase();
    try {
      final response = await dio.get(
          "https://66879a5f0bc7155dc0184943.mockapi.io/api/v1/users/user/?$key=$value");
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        List<ModelUser> users = data
            .map((value) => ModelUser.fromJSON(value))
            .where((e) =>
                e.id.toLowerCase().contains(tmpValue) ||
                e.name.toLowerCase().contains(tmpValue) ||
                e.age.toString().contains(tmpValue) ||
                e.address.toLowerCase().contains(tmpValue) ||
                e.email.toLowerCase().contains(tmpValue))
            .toList();

        return users;
      } else {
        throw "No value ! ";
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> updateData(String id, Map<String, dynamic> data) async {
    try {
      final response = await dio.put(
          'https://66879a5f0bc7155dc0184943.mockapi.io/api/v1/users/user/$id',
          data: data);
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

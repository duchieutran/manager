import 'package:appdemo/global/api/api_error.dart';
import 'package:appdemo/global/api/rest_client.dart';
import 'package:dio/dio.dart';
import 'package:appdemo/models/model_user.dart';
import 'package:appdemo/services/reponsitory/home_reponsitory.dart';

class HomeService extends HomeReponsitory {
  final RestClient _restClient = RestClient(
      baseURL: "https://66879a5f0bc7155dc0184943.mockapi.io/api/v1/users1");
  final dio = Dio();

  @override
  Future<bool> createData(ModelUser user) async {
    try {
      final response = await _restClient.post('/user', data: user.toJSON());
      if (response is Map) {
        return true;
      } else {
        throw ApiError.fromResponse(response);
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> deteleData(String id) async {
    try {
      await _restClient.delete('/user/$id');
      return true;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<ModelUser>> getData() async {
    try {
      final response = await _restClient.get('/user');
      if (response is List<dynamic>) {
        final tmp = response;
        List<ModelUser> user =
            tmp.map((value) => ModelUser.fromJSON(value)).toList();
        return user;
      } else {
        throw ApiError.fromResponse(response);
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<ModelUser>> searchData(String key, String value) async {
    final tmpValue = value.toLowerCase();
    try {
      final response =
          await _restClient.get("/user", queryParameters: {key: value});
      List<dynamic> data = response;
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
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> updateData(String id, Map<String, dynamic> data) async {
    try {
      await _restClient.put('/user/$id', data: data);
      return true;
    } catch (e) {
      rethrow;
    }
  }
}

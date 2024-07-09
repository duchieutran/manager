import 'package:appdemo/models/model_user.dart';

abstract class HomeReponsitory {
  // lay gia tri
  Future<List<ModelUser>> getData();

  // tim kiem gia tri
  Future<List<ModelUser>> searchData(String key, String value);

  // xoa gia tri
  Future<bool> deteleData(String id);

  // update gia tri
  Future<ModelUser> updateData();

  //tao moi gia tri
  Future<ModelUser> createData(ModelUser user);
}

import 'package:dio/dio.dart';
import 'package:shoe_box_client/model/user_model.dart';

class UserRepository {
  static Future<UserModel> fetchUser() async {
    final response = await Dio().get('http://0.0.0.0:8000/user/?user_id=45');

    return response.data;
  }
}

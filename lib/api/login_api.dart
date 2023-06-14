import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import '../const/api_domain.dart' as api_domain;
import '../const/globals.dart' as globals;

class APIService {
  static String baseURL = api_domain.domain;

  Future<bool> signupPost(Map signupData) async {
    var body = json.encode(signupData);
    final response = await http.post(
      Uri.parse('$baseURL/signup'),
      headers: {"Content-Type": "application/json"},
      body: body,
    );

    if (response.statusCode == 201) {
      // Login successful
      log('Signup Success');

      return true;
    } else {
      // Login failed
      return false;
    }
  }

  Future<(bool, String)> loginPost(String id, String password) async {
    Map loginData = {"id": id, "password": password};
    var body = json.encode(loginData);
    final response = await http.post(
      Uri.parse('$baseURL/login'),
      headers: {"Content-Type": "application/json"},
      body: body,
    );

    if (response.statusCode == 200) {
      // Login successful
      log('Login Success');
      await getUser(response.body);
      return (true, response.body);
    } else {
      // Login failed
      return (false, "");
    }
  }

  Future<void> getUser(String userId) async {
    try {
      final response =
          await http.get(Uri.parse('$baseURL/user/?user_id=$userId'));
      if (response.statusCode == 200) {
        final decodeData = utf8.decode(response.bodyBytes);
        globals.Globals.userData = json.decode(decodeData);
      } else {
        log('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      log('Error: $e');
    }
  }

  Future<bool> recommendPost(int id, String brand) async {
    log(id.toString());
    log(brand);
    final response = await http.post(
      Uri.parse('$baseURL/user/recom/?id=$id&brand=$brand'),
    );

    if (response.statusCode == 200) {
      // Login successful
      await getUser(id.toString());
      return true;
    } else {
      // Login failed
      return false;
    }
  }

  Future<bool> sizeFeedback(int id, String brand, int size) async {
    log(id.toString());
    log(brand);
    final response = await http.post(
      Uri.parse('$baseURL/review/?id=$id&brand=$brand&size=$size'),
    );

    if (response.statusCode == 200) {
      // Login successful
      await getUser(id.toString());
      return true;
    } else {
      // Login failed
      return false;
    }
  }
}

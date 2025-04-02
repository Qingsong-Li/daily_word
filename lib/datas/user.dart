import 'package:http/http.dart' as http;
// import 'dart:convert'; // 用于处理 JSON 数据
import 'package:shared_preferences/shared_preferences.dart';

class User {
  static Future<bool> login(String userName, String password) async {
    String token;
    final response = await http.post(
      Uri.parse('http://118.178.254.29:8888/user/login'),
      headers: <String, String>{},
      body: {
        'username': userName,
        'password': password,
      },
    );
    if (response.statusCode == 200) {
      token = response.body;
      token = token.replaceAll('"','');
      // print("登录成功");
      // print("账号：$userName");
      // print("密码：$password");
      // print("返回的token：$token");
      _saveToken(token);
      return true;
    } else {
      // 如果请求失败，则抛出异常或处理错误
      print("password error Failed to retrieve token ");
      print(response.body);
      _saveToken("");
      return false;
    }

  }

  static void _saveToken(String token) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString("token", token);
  }

  static void logout() async{ 
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("isLogined", false);
    prefs.setString("token", "");
  }
}

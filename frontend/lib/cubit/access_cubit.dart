import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import '../pages/logic/secure_storage_manager.dart';
part 'access_state.dart';

class AccessCubit extends Cubit<AccessState> {
  AccessCubit() : super(const AccessInit()) {
    testConnection();
  }

  final _secureStorageManager = SecureStorageManager.instance;


  Future<void> testConnection() async {
    emit(const Splash());
    final url = Uri.parse('https://butex.onrender.com/api/v1/hello-world/all');
    final response = await http.get(
      url,
      headers: {
        'accept': '*/*',
      },
    );

    if (response.statusCode == 200) {
      emit(const LogIn());
    } else {
      //tu dodac error
    }
    emit(const LogIn());
  }

  Future<void> moveToRegister() async {
    emit(const Register());
  }

  Future<void> moveToLog() async {
    emit(const LogIn());
  }

  Future<void> register(String name, String email, String password) async {
    final url = Uri.parse('https://butex.onrender.com/api/v1/auth/signup');
    final response = await http.post(
      url,
      headers: {
        'accept': '*/*',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "email": email,
        "firstName": name,
        "lastName": name,
        "password": password,
        "confirmPassword": password
      }),
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      final token = responseBody['token'];
      if (token != null) {
        await _secureStorageManager.write('auth_token', token);
        print("Jest Token");
        emit(const UserIn());
      }
      else {
        print("NIe ma token");
        print("Response body: ${responseBody}");
      }
    } else {
      print('Error: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  }

  Future<void> logIn(String email, String password) async {
    final url = Uri.parse('https://butex.onrender.com/api/v1/auth/signin');
    final response = await http.post(
      url,
      headers: {
        'accept': '*/*',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      final token = responseBody['token'];
      if (token != null) {
        await _secureStorageManager.write('auth_token', token);
        print("Jest Token");
        emit(const UserIn());
      }
      else {
        print("NIe ma token");
        print("Response body: ${responseBody}");
      }
    } else {
      print('porblem z logowaniem');
    }
    emit(const UserIn());
  }
}

import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import '../pages/logic/secure_storage_manager.dart';

part 'access_state.dart';

class AccessCubit extends Cubit<AccessState> {
  AccessCubit() : super(const AccessInit()) {
    _initializeNotifications();
    testConnection();
  }

  final _secureStorageManager = SecureStorageManager.instance;
  final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> _initializeNotifications() async {
    const androidInitialization =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const iOSInitialization = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const initializationSettings = InitializationSettings(
      android: androidInitialization,
      iOS: iOSInitialization,
    );

    await _notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _onSelectNotification,
    );
  }

  Future<void> _showNotification(String title, String body) async {
    const androidDetails = AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      importance: Importance.high,
      priority: Priority.high,
    );

    const iOSDetails = DarwinNotificationDetails();

    const notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iOSDetails,
    );

    await _notificationsPlugin.show(0, title, body, notificationDetails);
  }

  void _onSelectNotification(NotificationResponse notificationResponse) {
    print('Notification clicked with payload: ${notificationResponse.payload}');
  }

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
      await _showNotification(
          "Blad polaczenia", "Brak polaczenia z internetem");
      return;
    }
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

        await _showNotification(
            "Registration Success", "You are now registered!");
        emit(const UserIn());
      } else {
        print("Nie ma token");
        print("Response body: $responseBody");
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

        final url = Uri.parse('https://butex.onrender.com/api/v1/notification');

        final headers = {
          'accept': '*/*',
          'Authorization': 'Bearer $token',
        };

        final responseNot = await http.get(url, headers: headers);
        List<int> ids = [];
        List<String> status = [];
        final List data = json.decode(responseNot.body);
        for (var i = 0; i < data.length; i++) {
          ids.add(data[i]["id"]);
          status.add(data[i]["status"]);
        }

        for (var i = 0; i < ids.length; i++) {
          if (status[i] != "CANCELED" || status[i] != "RETURNED") {
            Timer(const Duration(seconds: 1), () async {
              await _showNotification(
                  "Order no:${ids[i]}", "Status: ${status[i]}");
            });
          }
        }

        emit(const UserIn());
      } else {
        print("Nie ma token");
        print("Response body: $responseBody");
      }
    } else {
      print('Problem z logowaniem');
    }
  }
}

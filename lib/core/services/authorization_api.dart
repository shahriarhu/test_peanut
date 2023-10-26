import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_peanut/ui/shared/api_url.dart';
import 'package:test_peanut/ui/widgets/simple_notification_widget.dart';

class AuthorizationAPI {
  Future<int?> signInAPI(
    String id,
    String password,
  ) async {
    try {
      final SharedPreferences preferences =
          await SharedPreferences.getInstance();
      http.Response response = await http.post(
        Uri.parse('${coreUrl}IsAccountCredentialsCorrect'),
        headers: {HttpHeaders.contentTypeHeader: 'application/json'},
        body: jsonEncode({
          'login': id,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        preferences.setString('token', jsonDecode(response.body)['token']);

        preferences.setString('userId', id);
      } else {
        simpleNotificationWidget(
          statusCode: response.statusCode,
          message: 'Invalid credentials',
        );
      }

      return response.statusCode;
    } on TimeoutException {
      simpleNotificationWidget(message: 'Connection timeout');
    } on SocketException {
      simpleNotificationWidget(message: 'Please check your connection');
    } on Error {
      simpleNotificationWidget(message: 'Unexpected error occurred');
    } on FormatException {
      simpleNotificationWidget(message: 'Server is under maintenance');
    } catch (e) {
      simpleNotificationWidget(message: 'Something went wrong');
    }
    return null;
  }
}

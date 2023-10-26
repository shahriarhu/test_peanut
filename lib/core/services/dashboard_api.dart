import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_peanut/core/models/user_profile_model.dart';
import 'package:test_peanut/core/models/user_trades_model.dart';
import 'package:test_peanut/ui/route_navigation.dart';
import 'package:test_peanut/ui/shared/api_url.dart';
import 'package:test_peanut/ui/widgets/simple_notification_widget.dart';

class DashboardAPI {
  Future<UserProfileModel?> getAccountInformationAPI() async {
    try {
      final SharedPreferences preferences =
          await SharedPreferences.getInstance();
      String? id = preferences.getString('userId');
      String? token = preferences.getString('token');

      http.Response response = await http.post(
        Uri.parse('${coreUrl}GetAccountInformation'),
        headers: {HttpHeaders.contentTypeHeader: 'application/json'},
        body: jsonEncode({
          'login': id,
          'token': token,
        }),
      );

      if (response.statusCode == 200) {
        UserProfileModel userProfile = userProfileModelFromJson(response.body);

        return userProfile;
      } else if (response.statusCode == 500) {
        await globalSignOut(
          response.statusCode,
        );
      } else {
        simpleNotificationWidget(
          statusCode: response.statusCode,
          message: 'Invalid credentials',
        );
      }
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

  Future<String?> getLastFourNumbersPhoneAPI() async {
    try {
      final SharedPreferences preferences =
          await SharedPreferences.getInstance();

      String? id = preferences.getString('userId');
      String? token = preferences.getString('token');

      http.Response response = await http.post(
        Uri.parse('${coreUrl}GetLastFourNumbersPhone'),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          // HttpHeaders.authorizationHeader: 'Bearer ${token!}',
        },
        body: jsonEncode({
          'login': id,
          'token': token,
        }),
      );

      if (response.statusCode == 200) {
        return response.body;
      } else if (response.statusCode == 500) {
        await globalSignOut(
          response.statusCode,
        );
      } else {
        simpleNotificationWidget(
          statusCode: response.statusCode,
          message: 'Invalid credentials',
        );
      }
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
    return '';
  }

  Future<List<UserTradesModel>?> getOpenTradesAPI() async {
    try {
      final SharedPreferences preferences =
          await SharedPreferences.getInstance();
      String? id = preferences.getString('userId');
      String? token = preferences.getString('token');

      http.Response response = await http.post(
        Uri.parse('${coreUrl}GetOpenTrades'),
        headers: {HttpHeaders.contentTypeHeader: 'application/json'},
        body: jsonEncode({
          'login': id,
          'token': token,
        }),
      );

      if (response.statusCode == 200) {
        List<UserTradesModel> userTrades =
            userTradesModelFromJson(response.body);

        return userTrades;
      } else if (response.statusCode == 500) {
        await globalSignOut(
          response.statusCode,
        );
      } else {
        simpleNotificationWidget(
          statusCode: response.statusCode,
          message: 'Invalid credentials',
        );
      }
      return null;
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

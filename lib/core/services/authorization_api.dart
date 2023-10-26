import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_peanut/ui/shared/api_url.dart';
import 'package:test_peanut/ui/widgets/simple_notification_widget.dart';
import 'package:xml/xml.dart';

class AuthorizationAPI {
  Future<int?> signInAPI(
    String id,
    String password,
  ) async {
    try {
      final SharedPreferences preferences = await SharedPreferences.getInstance();
      http.Response response = await http.post(
        Uri.parse('${coreUrl}IsAccountCredentialsCorrect'),
        headers: {HttpHeaders.contentTypeHeader: 'application/json'},
        body: jsonEncode({
          'login': id,
          'password': password,
        }),
      );

      log(response.body);

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

  Future<void> getPromotions() async {
    var url = Uri.parse('https://api-forexcopy.contentdatapro.com/Services/CabinetMicroService.svc');

    var headers = {
      'Content-Type': 'text/xml',
      'SOAPAction': 'http://tempuri.org/CabinetMicroService/GetCCPromo',
      // Add any other headers if needed
    };

    var body = '''
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:web="http://tempuri.org/">
   <soapenv:Header/>
   <soapenv:Body>
      <web:GetCCPromo>
         <web:lang>en</web:lang>
      </web:GetCCPromo>
   </soapenv:Body>
</soapenv:Envelope>
  ''';

    var response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      log(response.body);

      print('Success!');
      var document = XmlDocument.parse(response.body);
      var jsonData = document.findAllElements('GetCCPromoResult').first.text.trim();
      var promoData = json.decode(jsonData);
      log(promoData);
    } else {
      print('Failed with status code: ${response.statusCode}');
    }

    // return response.body;
  }
}

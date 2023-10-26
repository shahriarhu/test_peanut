import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_peanut/core/enums/view_state.dart';
import 'package:test_peanut/core/services/authorization_api.dart';
import 'package:test_peanut/core/view_models/base_view_model.dart';
import 'package:test_peanut/locator.dart';
import 'package:xml/xml.dart';

class SignInViewModel extends BaseViewModel {
  final GlobalKey<FormState> formKey = GlobalKey();
  final AuthorizationAPI _authorizationAPI = locator<AuthorizationAPI>();

  final iDController = TextEditingController();
  final passwordController = TextEditingController();

  bool _isPasswordVisible = false;

  bool get isPasswordVisible => _isPasswordVisible;

  void changeIsPasswordVisible() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }

  Future<void> setSavedPassword() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();

    iDController.text = preferences.getString('savedId') ?? '';
    passwordController.text = preferences.getString('savedPassword') ?? '';

    if (iDController.text.isNotEmpty) {
      _isCredentialsSaved = true;
    }

    notifyListeners();
  }

  Future<bool> signIn() async {
    setViewState(ViewState.busy);

    final SharedPreferences preferences = await SharedPreferences.getInstance();

    int? returnedStatusCode = await _authorizationAPI.signInAPI(iDController.text, passwordController.text);

    setViewState(ViewState.idle);

    if (returnedStatusCode == 200) {
      if (_isCredentialsSaved) {
        preferences.setString('savedId', iDController.text);
        preferences.setString('savedPassword', passwordController.text);
      } else {
        preferences.remove('savedId');
        preferences.remove('savedPassword');
      }

      return true;
    } else {
      preferences.remove('savedId');
      preferences.remove('savedPassword');

      return false;
    }
  }

  String? idValidator(String value) {
    if (value.isEmpty) {
      return 'Please, enter your id';
    } else if (value.length < 4) {
      return 'Id length must be 4 or more';
    } else if (value.length > 9) {
      return 'Id length must be 9 or less';
    }
    return null;
  }

  String? passwordValidator(String value) {
    String pattern = r"(^[a-zA-Z\d@%+'!#$^?:.~\-_.]{6,256}$)";
    RegExp regExp = RegExp(pattern);
    if (value.isEmpty) {
      return 'Password is required';
    } else if (!regExp.hasMatch(value)) {
      return 'Invalid character used';
    }
    return null;
  }

  bool _isCredentialsSaved = false;

  bool get isCredentialsSaved => _isCredentialsSaved;

  void toggleIsCredentialsSaved() async {
    _isCredentialsSaved = !_isCredentialsSaved;

    notifyListeners();
  }

  String? promotions;

  Future<void> getPromotions() async {
    setViewState(ViewState.busy);

    // promotions =
    (await _authorizationAPI.getPromotions());

    // convertToJson(promotions!);

    parsePromotions(promotions!);
    // parseSoapResponse(promotions!);
    // parseSoapResponse2(promotions!);

    XmlDocument.parse(promotions!);

    setViewState(ViewState.idle);
  }

  List<Promotion> parsePromotions(String xmlString) {
    var xmlDocument = XmlDocument.parse(xmlString);
    var promotions = <Promotion>[];

    for (var item in xmlDocument.findAllElements('GetCCPromoResult')) {
      var title = item.findElements('title').single.text;
      var description = item.findElements('description').single.text;
      var imageUrl = item.findElements('image_url').single.text.replaceAll('forex-images.instaforex.com', 'forex-images.ifxdb.com');
      var link = item.findElements('link').single.text;

      promotions.add(Promotion(title, description, imageUrl, link));
    }

    print('-------------------------------------------------------------');
    print(promotions);
    print('-------------------------------------------------------------');

    return promotions;
  }
  //
  // void parseSoapResponse(String responseBody) {
  //   var document = XmlDocument.parse(responseBody);
  //
  //   // Assuming the SOAP response has a structure like:
  //   // <s:Envelope><s:Body><InsertVisitCounterResponse><InsertVisitCounterResult>YOUR_RESULT_HERE</InsertVisitCounterResult></InsertVisitCounterResponse></s:Body></s:Envelope>
  //   // Adjust the path accordingly based on the actual SOAP response structure
  //
  //   var resultElement = document.findAllElements('InsertVisitCounterResult').first;
  //
  //   var resultValue = resultElement.text;
  //
  //   print('Parsed result: $resultValue');
  // }
  //
  // void parseSoapResponse2(String responseBody) {
  //   var document = XmlDocument.parse(responseBody);
  //
  //   // Extract the GetCCPromoResult element's text (which contains the JSON content)
  //   var jsonContent = document.findAllElements('GetCCPromoResult').single.text;
  //
  //   // Parse the JSON content
  //   Map<String, dynamic> jsonData = json.decode(jsonContent);
  //
  //   // You can now access the values in jsonData as required
  //   var forexCopy = jsonData['forex_copy'];
  //   print('Forex Copy Image: ${forexCopy['image']}');
  //   print('Forex Copy Text: ${forexCopy['text']}');
  //   // ... and so on for other properties and other parts of the jsonData
  //
  //   var ferrari = jsonData['ferrari'];
  //   print('Ferrari Image: ${ferrari['image']}');
  //   print('Ferrari Text: ${ferrari['text']}');
  //   // ... and so on for other properties
  // }

  void convertToJson(String xmlResponse) {
    // Parse the XML response
    var document = XmlDocument.parse(xmlResponse);

    // Extract the JSON data from the XML response
    var jsonData = document.findAllElements('GetCCPromoResult').first.text;

    // Parse the JSON data
    Map<String, dynamic> promoData = json.decode(jsonData);

    // Access the individual promo items
    var forexCopy = promoData['forex_copy'];
    var ferrari = promoData['ferrari'];
    var tether = promoData['tether'];
    var luckyDeposit = promoData['lucky_deposit'];

    // Use promoData as needed in your Dart code
    print(forexCopy);
    print(ferrari);
    print(tether);
    print(luckyDeposit);
  }
}

class Promotion {
  final String title;
  final String description;
  final String imageUrl;
  final String link;

  Promotion(this.title, this.description, this.imageUrl, this.link);
}

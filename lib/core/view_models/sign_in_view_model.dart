import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_peanut/core/enums/view_state.dart';
import 'package:test_peanut/core/services/authorization_api.dart';
import 'package:test_peanut/core/view_models/base_view_model.dart';
import 'package:test_peanut/locator.dart';

class SignInViewModel extends BaseViewModel {
  final GlobalKey<FormState> formKey = GlobalKey();
  final AuthorizationAPI _authorizationAPI = locator<AuthorizationAPI>();

  final iDController = TextEditingController();
  final passwordController = TextEditingController();

  /// To toggle obscure text (Password field)

  bool _isPasswordVisible = false;

  bool get isPasswordVisible => _isPasswordVisible;

  void changeIsPasswordVisible() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }

  /// Saving credentials only after a successful login

  Future<void> setSavedPassword() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();

    iDController.text = preferences.getString('savedId') ?? '';
    passwordController.text = preferences.getString('savedPassword') ?? '';

    if (iDController.text.isNotEmpty) {
      _isCredentialsSaved = true;
    }

    notifyListeners();
  }

  /// Authentication (IsAccountCredentialsCorrect)

  Future<bool> signIn() async {
    setViewState(ViewState.busy);

    final SharedPreferences preferences = await SharedPreferences.getInstance();

    int? returnedStatusCode = await _authorizationAPI.signInAPI(
        iDController.text, passwordController.text);

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

  /// Validator for credentials text field

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
}

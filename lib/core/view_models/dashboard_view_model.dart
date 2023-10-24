import 'package:flutter/widgets.dart';
import 'package:test_peanut/core/enums/view_state.dart';
import 'package:test_peanut/core/models/user_profile_model.dart';
import 'package:test_peanut/core/services/dashboard_api.dart';
import 'package:test_peanut/core/view_models/base_view_model.dart';
import 'package:test_peanut/locator.dart';

class DashboardViewModel extends BaseViewModel {
  final GlobalKey<FormState> formKey = GlobalKey();
  final DashboardAPI _dashboard = locator<DashboardAPI>();

  UserProfileModel userProfile = UserProfileModel();

  Future<void> getAccountInformation() async {
    setViewState(ViewState.busy);

    userProfile = (await _dashboard.getAccountInformationAPI())!;

    setViewState(ViewState.idle);
  }

  String lastFourNumbersPhone = '';

  Future<String> getLastFourNumbersPhone() async {
    setViewState(ViewState.busy);

    lastFourNumbersPhone = (await _dashboard.getLastFourNumbersPhoneAPI())!;

    setViewState(ViewState.idle);

    return lastFourNumbersPhone;
  }
}
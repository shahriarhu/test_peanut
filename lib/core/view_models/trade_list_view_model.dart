import 'package:flutter/widgets.dart';
import 'package:test_peanut/core/enums/view_state.dart';
import 'package:test_peanut/core/models/user_trades_model.dart';
import 'package:test_peanut/core/services/dashboard_api.dart';
import 'package:test_peanut/core/view_models/base_view_model.dart';
import 'package:test_peanut/locator.dart';

class TradeListViewModel extends BaseViewModel {
  final GlobalKey<FormState> formKey = GlobalKey();
  final DashboardAPI _dashboard = locator<DashboardAPI>();

  List<UserTradesModel> userTrades = [];

  Future<void> getOpenTrades() async {
    setViewState(ViewState.busy);

    userTrades = (await _dashboard.getOpenTradesAPI())!;

    setViewState(ViewState.idle);
  }
}

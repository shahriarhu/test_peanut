import 'package:flutter/widgets.dart';
import 'package:test_peanut/core/enums/view_state.dart';
import 'package:test_peanut/core/models/user_trades_model.dart';
import 'package:test_peanut/core/services/dashboard_api.dart';
import 'package:test_peanut/core/view_models/base_view_model.dart';
import 'package:test_peanut/locator.dart';

class TradeListViewModel extends BaseViewModel {
  final GlobalKey<FormState> formKey = GlobalKey();
  final DashboardAPI _dashboard = locator<DashboardAPI>();

  /// GetOpenTrades

  List<UserTradesModel> userTrades = [];

  Future<void> getOpenTrades() async {
    setViewState(ViewState.busy);

    userTrades = (await _dashboard.getOpenTradesAPI())!;

    setViewState(ViewState.idle);
  }

  double _totalProfit = 0;

  double get totalProfit => _totalProfit;

  void totalProfitCalculation() {
    _totalProfit = 0;
    for (var userTrade in userTrades) {
      _totalProfit = _totalProfit + userTrade.profit!;
    }
  }

  /// Converting ISO time format to normal

  String parseAndFormatDateTime(String inputDateTimeString) {
    DateTime parsedDateTime = DateTime.parse(inputDateTimeString);

    String formattedTime =
        '${parsedDateTime.hour}:${parsedDateTime.minute}:${parsedDateTime.second}';

    String formattedDate =
        '${parsedDateTime.year}-${_twoDigits(parsedDateTime.month)}-${_twoDigits(parsedDateTime.day)}';

    return 'Time: $formattedTime        Date: $formattedDate';
  }

  String _twoDigits(int n) {
    if (n >= 10) {
      return '$n';
    }
    return '0$n';
  }
}

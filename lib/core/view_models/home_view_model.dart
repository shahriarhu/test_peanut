import 'package:test_peanut/core/view_models/base_view_model.dart';
import 'package:test_peanut/ui/views/dashboard_view.dart';
import 'package:test_peanut/ui/views/trade_list_view.dart';

class HomeViewModel extends BaseViewModel {
  int _currentPage = 0;

  int get currentPage => _currentPage;

  set changePage(int page) {
    _currentPage = page;
    notifyListeners();
  }

  getPage() {
    switch (_currentPage) {
      case 0:
        return const DashboardView();
      case 1:
        return const TradeListView();
    }
  }
}

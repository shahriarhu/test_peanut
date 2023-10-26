import 'package:test_peanut/core/enums/view_state.dart';
import 'package:test_peanut/core/models/promo_model.dart';
import 'package:test_peanut/core/services/promo_api.dart';
import 'package:test_peanut/core/view_models/base_view_model.dart';
import 'package:test_peanut/locator.dart';

class PromoViewModel extends BaseViewModel {
  final PromoAPI _promoAPI = locator<PromoAPI>();

  PromoModel? promos;

  /// Promotional

  Future<void> getPromo() async {
    setViewState(ViewState.busy);

    promos = (await _promoAPI.getPromotionsAPI());

    setViewState(ViewState.idle);
  }
}

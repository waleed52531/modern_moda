import 'package:get/get.dart';

import '../../../core/config/app_config.dart';
import '../../../data/models/stock_quote.dart';
import '../../../data/repositories/market_repository.dart';

class MarketController extends GetxController {
  MarketController(this._repository);

  final MarketRepository _repository;
  final RxList<StockQuote> stocks = <StockQuote>[].obs;
  final RxBool loading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadMarket();
  }

  Future<void> loadMarket() async {
    loading.value = true;
    final data = await _repository.loadMarket(AppConfig.defaultTickers);
    stocks.assignAll(data);
    loading.value = false;
  }
}

import 'package:get/get.dart';

import '../../../core/config/app_config.dart';
import '../../../data/models/candle_point.dart';
import '../../../data/repositories/market_repository.dart';

class ChartController extends GetxController {
  ChartController(this._repository);

  final MarketRepository _repository;
  final RxList<CandlePoint> candles = <CandlePoint>[].obs;
  final RxString selectedTicker = AppConfig.defaultTickers.first.obs;
  final RxBool loading = false.obs;

  List<String> get availableTickers => AppConfig.defaultTickers;

  @override
  void onInit() {
    super.onInit();
    loadChart();
  }

  Future<void> loadChart({String? ticker}) async {
    if (ticker != null) {
      selectedTicker.value = ticker;
    }
    loading.value = true;
    final data = await _repository.loadChart(selectedTicker.value);
    candles.assignAll(data);
    loading.value = false;
  }
}

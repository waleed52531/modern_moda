import 'package:get/get.dart';

import '../../../data/providers/market_provider.dart';
import '../../../data/repositories/market_repository.dart';
import '../controllers/chart_controller.dart';
import '../controllers/market_controller.dart';
import '../controllers/news_controller.dart';
import '../controllers/sector_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    final provider = MarketProvider();
    final repository = MarketRepository(provider);

    Get.lazyPut(() => MarketController(repository));
    Get.lazyPut(() => ChartController(repository));
    Get.lazyPut(() => NewsController(repository));
    Get.lazyPut(() => SectorController(repository));
  }
}

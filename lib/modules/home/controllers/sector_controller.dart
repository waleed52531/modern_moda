import 'package:get/get.dart';

import '../../../data/models/sector_performance.dart';
import '../../../data/repositories/market_repository.dart';

class SectorController extends GetxController {
  SectorController(this._repository);

  final MarketRepository _repository;
  final RxList<SectorPerformance> sectors = <SectorPerformance>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadSectors();
  }

  Future<void> loadSectors() async {
    sectors.assignAll(await _repository.loadSectors());
  }
}

import 'package:get/get.dart';

import '../../../data/models/news_article.dart';
import '../../../data/repositories/market_repository.dart';

class NewsController extends GetxController {
  NewsController(this._repository);

  final MarketRepository _repository;
  final RxList<NewsArticle> news = <NewsArticle>[].obs;
  final RxBool loading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadNews();
  }

  Future<void> loadNews() async {
    loading.value = true;
    final data = await _repository.loadNews();
    news.assignAll(data);
    loading.value = false;
  }
}

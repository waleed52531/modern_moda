import '../models/candle_point.dart';
import '../models/news_article.dart';
import '../models/sector_performance.dart';
import '../models/stock_quote.dart';
import '../providers/market_provider.dart';
import '../sample_data.dart';

class MarketRepository {
  const MarketRepository(this._provider);

  final MarketProvider _provider;

  Future<List<StockQuote>> loadMarket(List<String> tickers) async {
    try {
      final responses = await _provider.fetchSnapshots(tickers);
      return responses.map(StockQuote.fromPolygon).toList();
    } catch (_) {
      return SampleData.market;
    }
  }

  Future<List<CandlePoint>> loadChart(String ticker) async {
    try {
      final response = await _provider.fetchChart(ticker);
      return response.map(CandlePoint.fromPolygon).toList();
    } catch (_) {
      return SampleData.chart;
    }
  }

  Future<List<NewsArticle>> loadNews() async {
    try {
      final response = await _provider.fetchNews();
      return response.map(NewsArticle.fromNewsApi).toList();
    } catch (_) {
      return SampleData.news;
    }
  }

  Future<List<SectorPerformance>> loadSectors() async {
    return SampleData.sectors;
  }
}

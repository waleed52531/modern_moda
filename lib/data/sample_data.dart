import 'models/candle_point.dart';
import 'models/news_article.dart';
import 'models/sector_performance.dart';
import 'models/stock_quote.dart';

class SampleData {
  const SampleData._();

  static const market = <StockQuote>[
    StockQuote(
      ticker: 'PSX:OGDC',
      name: 'Oil & Gas Dev',
      price: 112.4,
      change: 1.8,
      changePercent: 1.63,
      exchange: 'PSX',
    ),
    StockQuote(
      ticker: 'PSX:HBL',
      name: 'Habib Bank',
      price: 88.1,
      change: -0.6,
      changePercent: -0.68,
      exchange: 'PSX',
    ),
    StockQuote(
      ticker: 'AAPL',
      name: 'Apple',
      price: 186.9,
      change: 2.3,
      changePercent: 1.25,
      exchange: 'NASDAQ',
    ),
    StockQuote(
      ticker: 'MSFT',
      name: 'Microsoft',
      price: 323.4,
      change: -1.2,
      changePercent: -0.37,
      exchange: 'NASDAQ',
    ),
  ];

  static final chart = <CandlePoint>[
    for (int i = 0; i < 10; i++)
      CandlePoint(
        timestamp: DateTime.now().subtract(Duration(hours: 10 - i)),
        close: 180 + i * 0.8,
      ),
  ];

  static final news = <NewsArticle>[
    NewsArticle(
      title: 'Energy shares lead Pakistan market rebound',
      source: 'Dawn Business',
      publishedAt: DateTime.utc(2023, 10, 1, 10),
      url: 'https://example.com/pakistan-energy',
    ),
    NewsArticle(
      title: 'Tech megacaps push Nasdaq futures higher',
      source: 'Reuters',
      publishedAt: DateTime.utc(2023, 10, 1, 9, 30),
      url: 'https://example.com/nasdaq-tech',
    ),
  ];

  static const sectors = <SectorPerformance>[
    SectorPerformance(sector: 'Energy', changePercent: 1.9),
    SectorPerformance(sector: 'Financials', changePercent: -0.6),
    SectorPerformance(sector: 'Technology', changePercent: 0.8),
    SectorPerformance(sector: 'Materials', changePercent: 0.3),
  ];
}

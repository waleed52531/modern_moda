class StockQuote {
  const StockQuote({
    required this.ticker,
    required this.name,
    required this.price,
    required this.change,
    required this.changePercent,
    required this.exchange,
  });

  final String ticker;
  final String name;
  final double price;
  final double change;
  final double changePercent;
  final String exchange;

  factory StockQuote.fromPolygon(Map<String, dynamic> json) {
    final results = (json['results'] as List?)?.firstOrNull as Map<String, dynamic>?;
    final price = (results?['c'] as num? ?? 0).toDouble();
    final open = (results?['o'] as num? ?? price).toDouble();
    final change = price - open;
    final percent = open == 0 ? 0.0 : (change / open) * 100;

    return StockQuote(
      ticker: json['ticker'] as String? ?? '',
      name: json['name'] as String? ?? json['ticker'] as String? ?? '',
      price: price,
      change: change,
      changePercent: percent,
      exchange: json['exchange'] as String? ?? 'PSX / Global',
    );
  }
}

extension _ListFirstOrNull<T> on List<T> {
  T? get firstOrNull => isEmpty ? null : first;
}

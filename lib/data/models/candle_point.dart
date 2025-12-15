class CandlePoint {
  const CandlePoint({required this.timestamp, required this.close});

  final DateTime timestamp;
  final double close;

  factory CandlePoint.fromPolygon(Map<String, dynamic> json) {
    return CandlePoint(
      timestamp: DateTime.fromMillisecondsSinceEpoch((json['t'] as int?) ?? 0),
      close: (json['c'] as num? ?? 0).toDouble(),
    );
  }
}

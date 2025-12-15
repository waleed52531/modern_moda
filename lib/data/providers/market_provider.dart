import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../core/config/app_config.dart';

class MarketProvider {
  final http.Client _client;
  MarketProvider({http.Client? client}) : _client = client ?? http.Client();

  Future<List<Map<String, dynamic>>> fetchSnapshots(List<String> tickers) async {
    final responses = await Future.wait(
      tickers.map((ticker) async {
        final uri = Uri.parse(
          'https://api.polygon.io/v2/aggs/ticker/$ticker/prev?adjusted=true&apiKey=${AppConfig.polygonApiKey}',
        );
        final resp = await _client.get(uri);
        if (resp.statusCode == 200) {
          final json = jsonDecode(resp.body) as Map<String, dynamic>;
          json['ticker'] = ticker;
          return json;
        }
        throw Exception('Failed to fetch $ticker');
      }),
    );

    return responses;
  }

  Future<List<Map<String, dynamic>>> fetchChart(String ticker) async {
    final now = DateTime.now();
    final from = now.subtract(const Duration(days: 5));
    final uri = Uri.parse(
      'https://api.polygon.io/v2/aggs/ticker/$ticker/range/30/minute/${_format(from)}/${_format(now)}?adjusted=true&limit=120&apiKey=${AppConfig.polygonApiKey}',
    );
    final resp = await _client.get(uri);
    if (resp.statusCode == 200) {
      final json = jsonDecode(resp.body) as Map<String, dynamic>;
      return (json['results'] as List?)?.cast<Map<String, dynamic>>() ?? <Map<String, dynamic>>[];
    }
    throw Exception('Failed to fetch chart');
  }

  Future<List<Map<String, dynamic>>> fetchNews() async {
    final uri = Uri.parse(
      'https://newsapi.org/v2/everything?q=stocks&language=en&pageSize=10&apiKey=${AppConfig.newsApiKey}',
    );
    final resp = await _client.get(uri);
    if (resp.statusCode == 200) {
      final json = jsonDecode(resp.body) as Map<String, dynamic>;
      return (json['articles'] as List?)?.cast<Map<String, dynamic>>() ?? <Map<String, dynamic>>[];
    }
    throw Exception('Failed to fetch news');
  }

  String _format(DateTime date) =>
      '${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
}

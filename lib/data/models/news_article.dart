class NewsArticle {
  const NewsArticle({
    required this.title,
    required this.source,
    required this.publishedAt,
    required this.url,
  });

  final String title;
  final String source;
  final DateTime publishedAt;
  final String url;

  factory NewsArticle.fromNewsApi(Map<String, dynamic> json) {
    return NewsArticle(
      title: json['title'] as String? ?? 'Untitled',
      source: (json['source'] as Map?)?['name'] as String? ?? 'Unknown',
      publishedAt: DateTime.tryParse(json['publishedAt'] as String? ?? '') ?? DateTime.now(),
      url: json['url'] as String? ?? '',
    );
  }
}

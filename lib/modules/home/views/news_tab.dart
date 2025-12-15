import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/news_controller.dart';

class NewsTab extends GetView<NewsController> {
  const NewsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final formatter = DateFormat('MMM d, hh:mm a');
    return Obx(() {
      if (controller.loading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      return RefreshIndicator(
        onRefresh: controller.loadNews,
        child: ListView.separated(
          padding: const EdgeInsets.all(16),
          itemBuilder: (context, index) {
            final article = controller.news[index];
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(article.source, style: Theme.of(context).textTheme.bodyMedium),
                    const SizedBox(height: 6),
                    Text(article.title, style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 8),
                    Text(formatter.format(article.publishedAt.toLocal())),
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (_, __) => const SizedBox(height: 10),
          itemCount: controller.news.length,
        ),
      );
    });
  }
}

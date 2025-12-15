import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/config/app_config.dart';
import 'chart_tab.dart';
import 'market_tab.dart';
import 'news_tab.dart';
import 'sector_tab.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Stock Watch'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Market'),
              Tab(text: 'Graph'),
              Tab(text: 'News'),
              Tab(text: 'Sectors'),
            ],
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(AppConfig.primaryMarketLabel, style: Theme.of(context).textTheme.titleMedium),
                      const SizedBox(height: 6),
                      const Text('Polygon.io pricing + News API headlines'),
                    ],
                  ),
                  IconButton(
                    onPressed: () {
                      Get.snackbar('Layout', 'Modern minimal dashboard ready');
                    },
                    icon: const Icon(Icons.tune),
                  ),
                ],
              ),
            ),
            const Expanded(
              child: TabBarView(
                children: [
                  MarketTab(),
                  ChartTab(),
                  NewsTab(),
                  SectorTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

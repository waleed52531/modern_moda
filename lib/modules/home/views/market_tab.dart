import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/market_controller.dart';

class MarketTab extends GetView<MarketController> {
  const MarketTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.loading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      return RefreshIndicator(
        onRefresh: controller.loadMarket,
        child: ListView.separated(
          padding: const EdgeInsets.all(16),
          itemBuilder: (context, index) {
            final stock = controller.stocks[index];
            final positive = stock.change >= 0;
            final color = positive ? Colors.green : Colors.red;
            return Card(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: color.withOpacity(0.12),
                  child: Text(
                    stock.ticker.substring(0, 2).toUpperCase(),
                    style: TextStyle(color: color),
                  ),
                ),
                title: Text(stock.name, style: Theme.of(context).textTheme.titleMedium),
                subtitle: Text('${stock.exchange} • ${stock.ticker}'),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('Rs ${stock.price.toStringAsFixed(2)}'),
                    Text(
                      '${positive ? '+' : ''}${stock.change.toStringAsFixed(2)} (${stock.changePercent.toStringAsFixed(2)}%)',
                      style: TextStyle(color: color, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (_, __) => const SizedBox(height: 10),
          itemCount: controller.stocks.length,
        ),
      );
    });
  }
}

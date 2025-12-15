import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/chart_controller.dart';

class ChartTab extends GetView<ChartController> {
  const ChartTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Price action', style: Theme.of(context).textTheme.titleMedium),
              Obx(() => DropdownButton<String>(
                    value: controller.selectedTicker.value,
                    underline: const SizedBox(),
                    onChanged: (value) {
                      if (value != null) controller.loadChart(ticker: value);
                    },
                    items: controller.availableTickers
                        .map((ticker) => DropdownMenuItem<String>(
                              value: ticker,
                              child: Text(ticker),
                            ))
                        .toList(),
                  )),
            ],
          ),
          const SizedBox(height: 12),
          Obx(() {
            if (controller.loading.value) {
              return const Expanded(
                child: Center(child: CircularProgressIndicator()),
              );
            }

            if (controller.candles.isEmpty) {
              return const Expanded(child: Center(child: Text('No chart data yet.')));
            }

            final spots = controller.candles
                .asMap()
                .entries
                .map((entry) => FlSpot(entry.key.toDouble(), entry.value.close))
                .toList();

            return Expanded(
              child: LineChart(
                LineChartData(
                  minY: controller.candles.map((c) => c.close).reduce((a, b) => a < b ? a : b) * 0.99,
                  maxY: controller.candles.map((c) => c.close).reduce((a, b) => a > b ? a : b) * 1.01,
                  lineBarsData: [
                    LineChartBarData(
                      spots: spots,
                      color: Theme.of(context).colorScheme.secondary,
                      isCurved: true,
                      barWidth: 3,
                      dotData: const FlDotData(show: false),
                      belowBarData: BarAreaData(
                        show: true,
                        color: Theme.of(context).colorScheme.secondary.withOpacity(0.08),
                      ),
                    ),
                  ],
                  titlesData: const FlTitlesData(
                    topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  gridData: const FlGridData(show: true, drawVerticalLine: false),
                  borderData: FlBorderData(show: false),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}

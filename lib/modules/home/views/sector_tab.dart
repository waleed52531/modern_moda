import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/sector_controller.dart';

class SectorTab extends GetView<SectorController> {
  const SectorTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.4,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: controller.sectors.length,
        itemBuilder: (context, index) {
          final sector = controller.sectors[index];
          final positive = sector.changePercent >= 0;
          final color = positive ? Colors.green : Colors.red;
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(sector.sector, style: Theme.of(context).textTheme.titleMedium),
                  const Spacer(),
                  Text(
                    '${positive ? '+' : ''}${sector.changePercent.toStringAsFixed(2)}%',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: color),
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }
}

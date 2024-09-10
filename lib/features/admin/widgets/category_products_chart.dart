import 'package:amazon_clone/features/admin/models/sales.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CategoryProductsChart extends StatelessWidget {
  final List<Sales> data;
  const CategoryProductsChart({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        // Configure chart properties and styling here
        gridData: const FlGridData(show: false),
        titlesData: const FlTitlesData(show: false),
        borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xff37434d), width: 1),
        ),
        minX: 0,
        maxX: data.length.toDouble() - 1,
        minY: 0,
        maxY: 25, // Adjust maxY based on your data
        lineBarsData: [
          LineChartBarData(
            spots: data
                .asMap()
                .entries
                .map((entry) => FlSpot(
                    entry.key.toDouble(), entry.value.earning.toDouble()))
                .toList(),
            isCurved: true,
            color: const Color.fromARGB(255, 0, 255, 119),
            barWidth: 4,
            belowBarData: BarAreaData(show: false),
          ),
        ],
      ),
    );
  }
}

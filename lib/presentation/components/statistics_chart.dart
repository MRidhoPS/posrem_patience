import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:posrem_profileapp/util/app_util.dart';

class StatisticsChart extends StatelessWidget {
  final List<FlSpot> chartData;
  final Map<int, String> monthMap;

  const StatisticsChart({super.key, required this.chartData, required this.monthMap});

  @override
  Widget build(BuildContext context) {
    return chartData.isNotEmpty
        ? Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              height: AppUtil.screenHeight * 0.3,
              child: LineChart(
                LineChartData(
                  gridData: const FlGridData(show: false),
                  titlesData: FlTitlesData(
                    rightTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false)),
                    topTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false)),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        getTitlesWidget: (value, meta) => Text(
                          value.toString(),
                          style: const TextStyle(
                              color: Color(0xFF4B4B4B), fontSize: 12),
                        ),
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        reservedSize: 15,
                        showTitles: true,
                        getTitlesWidget: (double value, TitleMeta meta) {
                          String monthLabel = monthMap[value.toInt()] ?? '';
                          return Text(monthLabel,
                              style: const TextStyle(color: Color(0xFF4B4B4B)));
                        },
                        interval: 1,
                      ),
                    ),
                  ),
                  borderData: FlBorderData(
                      show: true,
                      border: Border.all(color: const Color(0xFF4B4B4B))),
                  lineBarsData: [
                    LineChartBarData(
                      spots: chartData,
                      isCurved: true,
                      color: Colors.white,
                      curveSmoothness: 0.50,
                      gradient: const LinearGradient(
                        colors: [
                          Color.fromARGB(255, 186, 186, 186),
                          Color.fromARGB(255, 235, 235, 235),
                          Color.fromARGB(255, 205, 205, 205),
                        ],
                      ),
                      barWidth: 3,
                      belowBarData: BarAreaData(show: false),
                    ),
                  ],
                ),
              ),
            ),
          )
        : const SizedBox.shrink();
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:posrem_profileapp/presentation/components/monthly_data_list.dart';
import 'package:posrem_profileapp/presentation/components/statistics_chart.dart';
import 'package:posrem_profileapp/presentation/components/year_header.dart';
import 'package:posrem_profileapp/presentation/provider/detail_user_provider.dart';
import 'package:provider/provider.dart';

class MonthlyDataPage extends StatelessWidget {
  final String userId;
  final String year;

  const MonthlyDataPage({super.key, required this.userId, required this.year});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        final provider = DetailUserProvider();
        provider.fetchDetailUser(userId).then((_) {
          provider.fetchMonthlyWeightData(userId, year);
        });
        return provider;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Monthly Data for $year'),
        ),
        body: Consumer<DetailUserProvider>(
          builder: (context, provider, child) {
            if (provider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (provider.userDetails == null) {
              return const Center(child: Text('No data available.'));
            } else {
              Map<int, String> monthMap = {
                1: "Jan",
                2: "Feb",
                3: "Mar",
                4: "Apr",
                5: "May",
                6: "Jun",
                7: "Jul",
                8: "Aug",
                9: "Sep",
                10: "Oct",
                11: "Nov",
                12: "Dec"
              };

              List<MapEntry<String, Map<String, dynamic>>> sortedEntries =
                  provider.weightDataByMonth.entries.toList()
                    ..sort(
                        (a, b) => int.parse(a.key).compareTo(int.parse(b.key)));

              List<FlSpot> chartData = sortedEntries
                  .map((entry) {
                    int monthIndex = int.tryParse(entry.key) ?? 0;
                    if (monthIndex < 1 || monthIndex > 12) return null;
                    double weight =
                        double.tryParse(entry.value['weight'].toString()) ??
                            0.0;
                    return FlSpot(monthIndex.toDouble(), weight);
                  })
                  .whereType<FlSpot>()
                  .toList();

              final data = provider.userDetails!;
              final yearData = data['data'][year] ?? {};
              if (yearData.isEmpty) {
                return const Center(
                    child: Text('No monthly data available for this year.'));
              }

              List<String> sortedMonthKeys = yearData.keys.toList()
                ..sort((a, b) {
                  Timestamp createdAtA = yearData[a]['createdAt'];
                  Timestamp createdAtB = yearData[b]['createdAt'];
                  return createdAtA.compareTo(createdAtB);
                });

              return SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      YearHeader(
                        year: year,
                      ),
                      StatisticsChart(
                        chartData: chartData,
                        monthMap: monthMap,
                      ),
                      MonthlyDataList(
                        sortedMonthKeys: sortedMonthKeys,
                        yearData: yearData,
                        userId: userId,
                        year: year,
                      ),
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:posrem_profileapp/presentation/page/detail_data_page.dart';
import 'package:posrem_profileapp/presentation/provider/detail_user_provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:rive/rive.dart' as rive; // Import untuk format tanggal

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
              // untuk chart
              // Mapping nama bulan ke angka (1 - 12)
              // Mapping angka bulan ke nama bulan (gunakan angka 1-12)
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

// Pastikan data diurutkan dengan benar berdasarkan angka bulan
              List<MapEntry<String, Map<String, dynamic>>> sortedEntries =
                  provider.weightDataByMonth.entries.toList()
                    ..sort(
                        (a, b) => int.parse(a.key).compareTo(int.parse(b.key)));

              List<FlSpot> chartData = sortedEntries
                  .map((entry) {
                    int monthIndex = int.tryParse(entry.key) ?? 0;

                    // Hindari data dengan bulan di luar rentang 1-12
                    if (monthIndex < 1 || monthIndex > 12) return null;

                    double weight =
                        double.tryParse(entry.value['weight'].toString()) ??
                            0.0;
                    return FlSpot(monthIndex.toDouble(), weight);
                  })
                  .whereType<FlSpot>()
                  .toList();

              // untuk next page
              final data = provider.userDetails!;
              final yearData =
                  data['data'][year] ?? {}; // Ambil data tahun yang relevan

              if (yearData.isEmpty) {
                return const Center(
                    child: Text('No monthly data available for this year.'));
              }

              // **Urutkan berdasarkan bulan (01 - 12)**
              List<String> sortedMonthKeys = yearData.keys.toList()
                ..sort((a, b) {
                  // Konversi key ke integer agar bisa diurutkan
                  Timestamp createdAtA = yearData[a]['createdAt'];
                  Timestamp createdAtB = yearData[b]['createdAt'];
                  return createdAtA.compareTo(createdAtB);
                });

              return SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.25,
                        child: Row(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.35,
                              decoration: const BoxDecoration(
                                  color: Color.fromARGB(255, 250, 185, 180),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                  )),
                              child: Center(
                                child: Text(
                                  year,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 30,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                  ),
                                ),
                                child: const rive.RiveAnimation.asset(
                                  antialiasing: false,
                                  'assets/rope.riv',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 20, top: 20),
                        child: Text(
                          'Statistic Berat Badan:',
                          style:
                              TextStyle(fontSize: 14, color: Color(0xFF4B4B4B)),
                        ),
                      ),

                      if (chartData.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: SizedBox(
                            height: 250,
                            child: LineChart(
                              LineChartData(
                                gridData: const FlGridData(show: false),
                                titlesData: FlTitlesData(
                                  rightTitles: const AxisTitles(
                                      sideTitles:
                                          SideTitles(showTitles: false)),
                                  topTitles: const AxisTitles(
                                      sideTitles:
                                          SideTitles(showTitles: false)),
                                  leftTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                      showTitles: true,
                                      reservedSize: 40,
                                      getTitlesWidget: (value, meta) => Text(
                                        value.toString(),
                                        style: const TextStyle(
                                            color: Color(0xFF4B4B4B),
                                            fontSize: 12),
                                      ),
                                    ),
                                  ),
                                  bottomTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                      reservedSize: 15,
                                      showTitles: true,

                                      getTitlesWidget:
                                          (double value, TitleMeta meta) {
                                        // Ambil nama bulan dari mapping
                                        String monthLabel =
                                            monthMap[value.toInt()] ?? '';
                                        return Text(monthLabel,
                                            style: const TextStyle(
                                                color: Color(0xFF4B4B4B)));
                                      },
                                      interval:
                                          1, // Pastikan setiap bulan ditampilkan
                                    ),
                                  ),
                                ),
                                borderData: FlBorderData(
                                    show: true,
                                    border: Border.all(
                                      color: const Color(0xFF4B4B4B),
                                    )),
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
                        ),

                      // Menampilkan data bulanan dari tahun yang dipilih
                      const Padding(
                        padding: EdgeInsets.only(left: 20, top: 20),
                        child: Text(
                          'Data Bulanan:',
                          style:
                              TextStyle(fontSize: 14, color: Color(0xFF4B4B4B)),
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: sortedMonthKeys.length,
                        itemBuilder: (context, index) {
                          String monthKey = sortedMonthKeys[index];
                          Map<String, dynamic> monthData = yearData[monthKey];

                          // Mengambil tanggal createdAt dan mengubahnya ke nama bulan
                          Timestamp createdAt = monthData['createdAt'];
                          String month =
                              DateFormat('MMMM').format(createdAt.toDate());

                          return Card(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: ListTile(
                              title: Text(month,
                                  style: const TextStyle(fontSize: 18)),
                              trailing: const Icon(Icons.arrow_forward_ios),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MonthlyDetailPage(
                                      userId: userId,
                                      year: year,
                                      month: monthKey,
                                      monthName: month,
                                      bmiDesc: monthData['bmiDesc'],
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 30,
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

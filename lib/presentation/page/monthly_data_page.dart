import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:posrem_profileapp/presentation/page/detail_data_page.dart';
import 'package:posrem_profileapp/presentation/provider/detail_user_provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart'; // Import untuk format tanggal

class MonthlyDataPage extends StatelessWidget {
  final String userId;
  final String year;

  const MonthlyDataPage({super.key, required this.userId, required this.year});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DetailUserProvider()..fetchDetailUser(userId),
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
              final data = provider.userDetails!;
              final yearData =
                  data['data'][year] ?? {}; // Ambil data tahun yang relevan

              if (yearData.isEmpty) {
                return const Center(
                    child: Text('No monthly data available for this year.'));
              }

              return SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 20, top: 20),
                        child: Text(
                          'Monthly Data:',
                          style: TextStyle(fontSize: 14, color: Colors.white70),
                        ),
                      ),
                      // Menampilkan data bulanan dari tahun yang dipilih
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: yearData.keys.length,
                        itemBuilder: (context, index) {
                          String monthKey = yearData.keys.elementAt(index);
                          Map<String, dynamic> monthData = yearData[monthKey];

                          // Mengambil tanggal createdAt dan mengubahnya ke bulan
                          Timestamp createdAt = monthData['createdAt'];
                          String month =
                              DateFormat('MMMM').format(createdAt.toDate());

                          return Card(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: ListTile(
                              title: Text(month,
                                  style: const TextStyle(
                                      fontSize: 18)), // Tampilkan nama bulan
                              subtitle: Text(
                                  'BB: ${monthData['bb']} | BMI: ${monthData['bmi']}'),
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
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        },
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

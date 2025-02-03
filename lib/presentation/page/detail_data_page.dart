import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:posrem_profileapp/presentation/provider/detail_user_provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class MonthlyDetailPage extends StatelessWidget {
  final String userId;
  final String year;
  final String month;
  final String monthName;

  const MonthlyDetailPage(
      {Key? key,
      required this.userId,
      required this.year,
      required this.month,
      required this.monthName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DetailUserProvider()..fetchDetailUser(userId),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Details for $monthName, $year'),
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

              if (yearData.isEmpty || !yearData.containsKey(month)) {
                return const Center(
                    child: Text('No data available for this month.'));
              }

              final monthData = yearData[month];

              // Mengambil tanggal createdAt dan mengubahnya ke format yang lebih user-friendly
              Timestamp createdAt = monthData['createdAt'];
              String formattedDate =
                  DateFormat('d MMMM yyyy').format(createdAt.toDate());

              return SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Monthly Details:',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 20),

                        // Menampilkan detail bulan
                        ListTile(
                          title: const Text('Date of Record'),
                          subtitle: Text(formattedDate),
                        ),
                        const Divider(),

                        ListTile(
                          title: const Text('BB (Body Weight)'),
                          subtitle: Text('${monthData['bb']} kg'),
                        ),
                        const Divider(),

                        ListTile(
                          title: const Text('BMI (Body Mass Index)'),
                          subtitle: Text('${monthData['bmi']}'),
                        ),
                        const Divider(),

                        ListTile(
                          title: const Text('BMI Description'),
                          subtitle: Text('${monthData['bmiDesc']}'),
                        ),
                        const Divider(),

                        ListTile(
                          title: const Text('Lila'),
                          subtitle: Text('${monthData['lila']} cm'),
                        ),
                        const Divider(),

                        ListTile(
                          title: const Text('LP (Waist Circumference)'),
                          subtitle: Text('${monthData['lp']} cm'),
                        ),
                        const Divider(),

                        ListTile(
                          title: const Text('TB (Height)'),
                          subtitle: Text('${monthData['tb']} cm'),
                        ),
                        const Divider(),

                        ListTile(
                          title: const Text('TD (Blood Pressure)'),
                          subtitle: Text('${monthData['td']} mmHg'),
                        ),
                        const Divider(),
                      ],
                    ),
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

import 'package:flutter/material.dart';
import 'package:posrem_profileapp/presentation/provider/detail_user_provider.dart';
import 'package:provider/provider.dart';

class MonthlyDetailPage extends StatelessWidget {
  final String userId;
  final String year;
  final String month;
  final String monthName;
  final String bmiDesc;

  const MonthlyDetailPage(
      {super.key,
      required this.userId,
      required this.year,
      required this.month,
      required this.monthName,
      required this.bmiDesc});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) {
          final provider = DetailUserProvider();
          provider.fetchDetailUser(userId).then((_) {
            provider.fetchMonthlyWeightData(userId, year);
          });
          return provider;
        }),
      ],
      child: Scaffold(
        appBar: AppBar(
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

              return SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 40),
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.3,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  offset: const Offset(0, 0),
                                  blurRadius: 0.2,
                                  color:
                                      const Color.fromARGB(255, 201, 201, 201)
                                          .withOpacity(0.05),
                                  blurStyle: BlurStyle.inner,
                                  spreadRadius: 15)
                            ],
                            shape: BoxShape.circle,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Your Body',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: monthData['bmiDesc'] == 'Healthy'
                                      ? const Color(0xFF4B4B4B)
                                      : Colors.red,
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Text(
                                '${monthData['bmi']}',
                                style: TextStyle(
                                  fontSize: 80,
                                  fontWeight: FontWeight.bold,
                                  color: monthData['bmiDesc'] == 'Healthy'
                                      ? const Color(0xFF4B4B4B)
                                      : Colors.red,
                                ),
                              ),
                              Text(
                                '${monthData['bmiDesc']}',
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w600,
                                  color: monthData['bmiDesc'] == 'Healthy'
                                      ? const Color(0xFF4B4B4B)
                                      : Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Menampilkan detail bulan

                        CardDetailData(
                          monthData: monthData,
                          title: 'Berat Badan',
                          data: 'bb',
                          satuan: 'kg',
                        ),
                        CardDetailData(
                          monthData: monthData,
                          title: 'Tinggi Badan (Height)',
                          data: 'tb',
                          satuan: 'cm',
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.45,
                              color: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 50),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Lingkar Lengan',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 18,
                                      color: Color(0xFF4B4B4B),
                                    ),
                                  ),
                                  Text(
                                    '${monthData['lila']} cm',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF4B4B4B),
                                      fontSize: 28,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.45,
                              color: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 50),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Lingkar Perut',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 18,
                                      color: Color(0xFF4B4B4B),
                                    ),
                                  ),
                                  Text(
                                    '${monthData['lp']} cm',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF4B4B4B),
                                      fontSize: 28,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CardDetailData(
                          monthData: monthData,
                          title: 'Tekanan Darah (Blood Pressure)',
                          data: 'td',
                          satuan: 'mmHg',
                        ),
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

class CardDetailData extends StatelessWidget {
  const CardDetailData({
    super.key,
    required this.monthData,
    required this.title,
    required this.data,
    required this.satuan,
  });

  final dynamic monthData;
  final String title;
  final String data;
  final String satuan;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(vertical: 50),
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
              offset: const Offset(0, 0),
              blurRadius: 0.2,
              color: const Color.fromARGB(255, 201, 201, 201).withOpacity(0.05),
              blurStyle: BlurStyle.inner,
              spreadRadius: 15)
        ],
      ),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 18,
              color: Color(0xFF4B4B4B),
            ),
          ),
          Text(
            '${monthData[data]} $satuan',
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Color(0xFF4B4B4B),
              fontSize: 28,
            ),
          ),
        ],
      ),
    );
  }
}

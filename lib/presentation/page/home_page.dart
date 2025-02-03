import 'package:flutter/material.dart';
import 'package:posrem_profileapp/presentation/components/container_welcome.dart';
import 'package:posrem_profileapp/presentation/page/monthly_data_page.dart';
import 'package:posrem_profileapp/presentation/provider/detail_user_provider.dart';
import 'package:provider/provider.dart';

class DetailUser extends StatelessWidget {
  const DetailUser({super.key, required this.userId});

  final String userId;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DetailUserProvider()..fetchDetailUser(userId),
      child: Scaffold(
        body: Consumer<DetailUserProvider>(
          builder: (context, provider, child) {
            if (provider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (provider.userDetails == null) {
              return const Center(child: Text('No data available.'));
            } else {
              final data = provider.userDetails!;
              return SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ContainerWelcome(data: data),
                      const SizedBox(height: 20),

                      /// **Menampilkan daftar tahun yang tersedia**
                      if (provider.availableYears.isNotEmpty) ...[
                        const Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Text(
                            'Available Years:',
                            style:
                                TextStyle(fontSize: 14, color: Colors.white70),
                          ),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: provider.availableYears.length,
                          itemBuilder: (context, index) {
                            String year = provider.availableYears[index];
                            return Card(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              child: ListTile(
                                title: Text(year,
                                    style: const TextStyle(fontSize: 18)),
                                trailing: const Icon(Icons.arrow_forward_ios),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MonthlyDataPage(
                                          userId: userId, year: year),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 20),
                      ],

                      /// **Menampilkan Monthly Data seperti sebelumnya**
                      const Padding(
                        padding: EdgeInsets.only(left: 20, top: 20),
                        child: Text(
                          'Monthly Data:',
                          style: TextStyle(fontSize: 14, color: Colors.white70),
                        ),
                      ),
                      // ListMonthlyData(monthlyData: provider.monthlyData),
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

import 'package:flutter/material.dart';
import 'package:posrem_profileapp/presentation/components/container_welcome.dart';
import 'package:posrem_profileapp/presentation/page/detail_information_page.dart';
import 'package:posrem_profileapp/presentation/page/monthly_data_page.dart';
import 'package:posrem_profileapp/presentation/provider/detail_user_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.userId});

  final String userId;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        final provider = DetailUserProvider();
        provider.fetchDetailUser(userId).then((_) {
          provider
              .fetchInformation(); // Fetch information after fetching user details
        });
        return provider;
      },
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
                            style: TextStyle(
                                fontSize: 14, color: Color(0xFF4B4B4B)),
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
                                splashColor: Colors.white,
                                tileColor: Colors.white,
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

                      /// **Information Section**
                      if (provider.listInformation.isNotEmpty) ...[
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            "Information",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: provider.informationDetails!.length,
                          itemBuilder: (context, index) {
                            // Extract document keys (info-1, info-2)
                            String docId = provider.informationDetails!.keys
                                .elementAt(index);
                            Map<String, dynamic> docData =
                                provider.informationDetails![docId]!;

                            return Card(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              child: ListTile(
                                  title: Text(
                                    docData['title'] as String,
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            DetailInformationPage(
                                          data: docData,
                                        ),
                                      ),
                                    );
                                  }),
                            );
                          },
                        ),
                      ],
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

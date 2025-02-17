import 'package:flutter/material.dart';
import 'package:posrem_profileapp/presentation/components/available_years_section.dart';
import 'package:posrem_profileapp/presentation/components/container_welcome.dart';
import 'package:posrem_profileapp/presentation/components/information_section.dart';
import 'package:posrem_profileapp/presentation/provider/detail_user_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.userId});

  final String userId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureProvider<DetailUserProvider>(
        create: (_) async {
          final provider = DetailUserProvider();
          await provider.fetchDetailUser(userId);
          await provider.fetchInformation();
          return provider;
        },
        initialData: DetailUserProvider(),
        child: Consumer<DetailUserProvider>(
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
                      AvailableYearsSection(provider: provider, userId: userId),
                      const SizedBox(height: 20),
                      InformationSection(provider: provider),
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

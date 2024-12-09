import 'package:flutter/material.dart';
import 'package:posrem_profileapp/presentation/components/container_welcome.dart';
import 'package:posrem_profileapp/presentation/components/list_monthly_data.dart';
import 'package:posrem_profileapp/presentation/provider/detail_user_provider.dart';
import 'package:provider/provider.dart';// For Timestamp

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
                      const SizedBox(height: 30),
                      const Padding(
                        padding: EdgeInsets.only(left: 20, top: 20),
                        child: Text(
                          'Monthly Data:',
                          style: TextStyle(fontSize: 14, color: Colors.white70),
                        ),
                      ),
                      ListMonthlyData(monthlyData: provider.monthlyData),
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
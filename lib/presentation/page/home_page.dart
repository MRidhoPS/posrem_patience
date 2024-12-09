import 'package:flutter/material.dart';
import 'package:posrem_profileapp/presentation/formatter.dart';
import 'package:posrem_profileapp/presentation/page/detail_data_page.dart';
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


class ListMonthlyData extends StatelessWidget {
  const ListMonthlyData({
    super.key,
    required this.monthlyData,
  });

  final List<Map<String, dynamic>> monthlyData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: monthlyData.length,
        itemBuilder: (context, index) {
          var entry = monthlyData[index];
    
          return ContentListData(entry: entry);
        },
      ),
    );
  }
}

class ContentListData extends StatelessWidget {
  const ContentListData({
    super.key,
    required this.entry,
  });

  final Map<String, dynamic> entry;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Card(
        color: Colors.white.withOpacity(0.2),
        child: ListTile(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailData(
                  data: entry,
                  title: Formatter().formatDate(entry),
                ),
              ),
            );
          },
          title: Text(
            Formatter().formatDate(entry),
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class ContainerWelcome extends StatelessWidget {
  const ContainerWelcome({
    super.key,
    required this.data,
  });

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.2,
      color: Colors.white.withOpacity(0.2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Welcome,",
            style: TextStyle(color: Colors.white60, fontSize: 18),
          ),
          Text(
            "${data['name']}",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 34,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
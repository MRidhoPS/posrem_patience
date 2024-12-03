import 'package:flutter/material.dart';
import 'package:posrem_profileapp/presentation/formatter.dart';
import 'package:posrem_profileapp/presentation/page/detail_data_page.dart';
import 'package:posrem_profileapp/presentation/provider/detail_user_provider.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // For Timestamp

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

              List<Map<String, dynamic>> monthlyData = [];
              if (data['data'] != null) {
                Map<String, dynamic> dataEntries = data['data'];
                dataEntries.forEach((key, value) {
                  var entry = value as Map<String, dynamic>;
                  monthlyData.add(entry);
                });

                // Sort monthly data by date (createdAt)
                monthlyData.sort((a, b) {
                  DateTime dateA = (a['createdAt'] as Timestamp).toDate();
                  DateTime dateB = (b['createdAt'] as Timestamp).toDate();
                  return dateA.compareTo(dateB);
                });
              }

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
                      ListMonthlyData(monthlyData: monthlyData),
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


// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class DetailUser extends StatelessWidget {
//   final String userId;

//   const DetailUser({Key? key, required this.userId}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Detail User'),
//       ),
//       body: FutureBuilder<DocumentSnapshot>(
//         future:
//             FirebaseFirestore.instance.collection('users').doc(userId).get(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           }
//           if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           }
//           if (!snapshot.hasData || !snapshot.data!.exists) {
//             return Center(child: Text('User data not found.'));
//           }

//           // Retrieve user data from the document
//           final userData = snapshot.data!.data() as Map<String, dynamic>;

//           return Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text('Name: ${userData['name'] ?? 'N/A'}'),
//                 Text('Gender: ${userData['born'] ?? 'N/A'}'),
//                 // Display other user data as needed
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

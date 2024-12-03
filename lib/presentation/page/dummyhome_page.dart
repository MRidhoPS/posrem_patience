import 'package:flutter/material.dart';
import 'package:posrem_profileapp/presentation/components/widget_user.dart';
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
        appBar: AppBar(
          title: const Text('User Details'),
        ),
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

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      WidgetUsers(data: data, title: 'Name', type: 'name'),
                      WidgetUsers(data: data, title: 'Gender', type: 'gender'),
                      WidgetUsers(data: data, title: 'Born', type: 'born'),
                      WidgetUsers(
                          data: data, title: 'Religion', type: 'religion'),
                      WidgetUsers(
                          data: data, title: 'Address', type: 'address'),
                      WidgetUsers(
                          data: data, title: 'Education', type: 'education'),
                      WidgetUsers(
                          data: data, title: 'Phone Number', type: 'phoneNum'),
                      const SizedBox(height: 30),
                      const Text(
                        'Monthly Data:',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      const SizedBox(height: 15),
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: monthlyData.length,
                        itemBuilder: (context, index) {
                          var entry = monthlyData[index];

                          return Card(
                            child: ListTile(
                              onTap: () {
                                // Navigate to DetailData if needed
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailData(
                                      data: entry,
                                      title: Formatter().formatDate(entry),
                                    ),
                                  ),
                                );
                                // );
                              },
                              title: Text(
                                Formatter().formatDate(entry),
                              ),
                              subtitle: Text('BMI: ${entry['bmi'] ?? 'N/A'}'),
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

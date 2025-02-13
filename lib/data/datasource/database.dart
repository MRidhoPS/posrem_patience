import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseServices {
  Future<Map<String, dynamic>> fetchUserById(String userId) async {
    final doc =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
    if (!doc.exists) {
      throw Exception('User not found');
    }
    return {'id': doc.id, ...doc.data() as Map<String, dynamic>};
  }

  Future<Map<String, Map<String, dynamic>>> fetchInformation() async {
    final querySnapshot =
        await FirebaseFirestore.instance.collection('information').get();

    // Convert documents into a Map<String, Map<String, dynamic>>
    Map<String, Map<String, dynamic>> informationMap = {
      for (var doc in querySnapshot.docs)
        doc.id: doc.data()
    };

    print('Fetched Information: $informationMap');
    return informationMap;
  }


  Future<List<String>> fetchDataYear(String userId) async {
    final doc =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();

    if (!doc.exists) {
      throw Exception('User not found');
    }

    // Ambil semua tahun yang tersedia dalam "data"
    Map<String, dynamic>? data = doc.data()?['data'];

    if (data != null) {
      return data.keys
          .toList(); // Mengembalikan daftar tahun (misal: ['2025', '2024'])
    }

    throw Exception('No year data found');
  }

  // 3. Ambil data bulanan dari tahun tertentu
  Future<Map<String, dynamic>> fetchMonthlyData(
      String userId, String year) async {
    final doc =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();

    if (!doc.exists) {
      throw Exception('User not found');
    }

    // Ambil data dari tahun yang dipilih
    Map<String, dynamic>? yearData = doc.data()?['data']?[year];

    if (yearData != null) {
      return yearData; // Mengembalikan semua entry bulanan dari tahun tersebut
    }

    throw Exception('No monthly data found for year $year');
  }
}

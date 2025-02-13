import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:posrem_profileapp/data/datasource/database.dart';
import 'package:intl/intl.dart';

class DetailUserProvider extends ChangeNotifier {
  final DatabaseServices _databaseServices = DatabaseServices();

  bool isLoading = false;
  Map<String, dynamic>? userDetails;
  Map<String, Map<String, dynamic>>? informationDetails;
  List<String> listInformation = [];
  List<String> availableYears = [];
  Map<String, Map<String, dynamic>> weightDataByMonth =
      {}; // Data berat badan per bulan

  /// Fetch user details
  Future<void> fetchDetailUser(String userId) async {
    isLoading = true;
    notifyListeners();

    try {
      userDetails = await _databaseServices.fetchUserById(userId);
      availableYears = userDetails?['data']?.keys.toList().cast<String>() ?? [];
    } catch (e) {
      debugPrint("Error fetching user details: $e");
      userDetails = null;
      availableYears = [];
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchInformation() async {
    isLoading = true;
    notifyListeners();

    try {
      // Fetch data as a map (doc ID -> doc data)
      informationDetails = await _databaseServices.fetchInformation();

      // Extract titles from each document
      listInformation = informationDetails!.values
          .map((doc) => doc['title'] as String)
          .toList();

      print('this is listInformation var = $listInformation');
    } catch (e) {
      debugPrint('Error fetching information: $e');
      informationDetails = null;
      listInformation = [];
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }



  /// Fetch data bulanan untuk chart berat badan
  Future<void> fetchMonthlyWeightData(String userId, String year) async {
    isLoading = true;
    notifyListeners();

    try {
      weightDataByMonth.clear();
      final data = userDetails?['data'][year] ?? {};

      for (var entry in data.entries) {
        var entryData = entry.value;
        Timestamp createdAt = entryData['createdAt'];
        String monthKey = DateFormat('MM')
            .format(createdAt.toDate()); // Simpan bulan dalam angka (01-12)
        String monthName =
            DateFormat('MMMM').format(createdAt.toDate()); // Simpan nama bulan

        if (entryData.containsKey('bb')) {
          double weight = double.tryParse(entryData['bb'].toString()) ?? 0.0;

          // Simpan hanya data terbaru dalam bulan itu
          if (!weightDataByMonth.containsKey(monthKey) ||
              createdAt.millisecondsSinceEpoch >
                  weightDataByMonth[monthKey]!['createdAt']
                      .millisecondsSinceEpoch) {
            weightDataByMonth[monthKey] = {
              'monthName': monthName,
              'weight': weight,
              'createdAt': createdAt,
              'bmi': entryData['bmi']
            };
          }
        }
      }
    } catch (e) {
      debugPrint("Error fetching monthly weight data: $e");
      weightDataByMonth = {};
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}

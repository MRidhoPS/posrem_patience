import 'package:flutter/material.dart';
import 'package:posrem_profileapp/data/datasource/database.dart';
import 'package:posrem_profileapp/data/formatter/monthly_formatter.dart';

class DetailUserProvider extends ChangeNotifier {
  final DatabaseServices _databaseServices = DatabaseServices();

  bool isLoading = false;
  Map<String, dynamic>? userDetails;
  List<Map<String, dynamic>> monthlyData = [];
  List<String> availableYears = []; // Tambahan untuk menyimpan data tahun

  /// Fetch user details (Tetap seperti sebelumnya)
  Future<void> fetchDetailUser(String userId) async {
    isLoading = true;
    notifyListeners();

    try {
      // Ambil data pengguna dari Firestore
      userDetails = await _databaseServices.fetchUserById(userId);

      // Ambil data tahun dari userDetails['data']
      availableYears = userDetails?['data']?.keys.toList().cast<String>() ?? [];

      // Offload processing ke background isolate
      monthlyData = await MonthlyDataProcessor.processDataAsync(
        userDetails!['data'],
        userId,
      );
    } catch (e) {
      debugPrint("Error fetching user details: $e");
      userDetails = null;
      monthlyData = [];
      availableYears = [];
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  /// Fetch hanya daftar tahun tanpa mempengaruhi data lainnya
  Future<void> fetchAvailableYears(String userId) async {
    isLoading = true;
    notifyListeners();

    try {
      availableYears = await _databaseServices.fetchDataYear(userId);
    } catch (e) {
      debugPrint("Error fetching available years: $e");
      availableYears = [];
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}

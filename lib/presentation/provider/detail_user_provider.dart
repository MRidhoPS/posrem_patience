import 'package:flutter/material.dart';
import 'package:posrem_profileapp/data/datasource/database.dart';
import 'package:posrem_profileapp/data/formatter/monthly_formatter.dart';

class DetailUserProvider extends ChangeNotifier {
  final DatabaseServices _databaseServices = DatabaseServices();

  bool isLoading = false;
  Map<String, dynamic>? userDetails;
  List<Map<String, dynamic>> monthlyData = [];

  Future<void> fetchDetailUser(String userId) async {
    isLoading = true;
    notifyListeners();

    try {
      // Fetch user data using DatabaseServices
      userDetails = await _databaseServices.fetchUserById(userId);

      // Offload processing to background isolate
      monthlyData = await MonthlyDataProcessor.processDataAsync(
        userDetails!['data'],
        userId,
      );
    } catch (e) {
      debugPrint("Error fetching user details: $e");
      userDetails = null;
      monthlyData = [];
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}

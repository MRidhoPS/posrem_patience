import 'package:flutter/material.dart';
import 'package:posrem_profileapp/data/datasource/database.dart';

class DetailUserProvider extends ChangeNotifier{
  Map<String, dynamic>? userDetails;
  bool isLoading = false;

  Future<void> fetchDetailUser(String userId) async {
    isLoading = true;
    notifyListeners();

    try {
      userDetails = await DatabaseServices().fetchUserById(userId);
    } catch (e) {
      userDetails = null;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
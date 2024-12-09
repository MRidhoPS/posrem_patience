import 'package:cloud_firestore/cloud_firestore.dart';

import 'dart:developer';
import 'package:flutter/foundation.dart';

class MonthlyDataProcessor {
  static List<Map<String, dynamic>>? _cache; // Cached data
  static String? _lastProcessedUserId; // Track user ID for cache validation

  // Process data in background using compute
  static Future<List<Map<String, dynamic>>> processDataAsync(
      Map<String, dynamic>? data, String userId) async {
    if (_lastProcessedUserId == userId && _cache != null) {
      // Return cached result if user ID matches
      log("Using cached monthly data.");
      return _cache!;
    }
    log("Processing monthly data in background...");
    return compute(_processData, {'data': data, 'userId': userId});
  }

  static List<Map<String, dynamic>> _processData(Map<String, dynamic> input) {
    final data = input['data'] as Map<String, dynamic>?;
    if (data == null) return [];

    final List<Map<String, dynamic>> monthlyData = [];
    data.forEach((key, value) {
      final entry = value as Map<String, dynamic>;
      monthlyData.add(entry);
    });

    // Sort monthly data by date
    monthlyData.sort((a, b) {
      final dateA = (a['createdAt'] as Timestamp).toDate();
      final dateB = (b['createdAt'] as Timestamp).toDate();
      return dateA.compareTo(dateB);
    });

    // Update cache
    _cache = monthlyData;
    _lastProcessedUserId = input['userId'];
    return monthlyData;
  }
}


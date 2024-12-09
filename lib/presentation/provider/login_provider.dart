import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:posrem_profileapp/presentation/page/home_page.dart';

class LoginProvider extends ChangeNotifier {
  final nameController = TextEditingController();
  String selectedGender = 'Pria';
  bool isLoading = false;

  void setGender(String gender) {
    selectedGender = gender;
    notifyListeners();
  }

  Future<void> loginUser(BuildContext context) async {
    final name = nameController.text.trim();

    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Nama harus diisi!")),
      );
      return;
    }

    isLoading = true;
    notifyListeners();

    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('name', isEqualTo: name)
          .where('gender', isEqualTo: selectedGender)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final userData = querySnapshot.docs.first.id;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => DetailUser(userId: userData),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Nama atau gender salah!")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Terjadi kesalahan saat login")),
      );
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}

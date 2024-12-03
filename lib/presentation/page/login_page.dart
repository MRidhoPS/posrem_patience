import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:posrem_profileapp/presentation/page/dummyhome_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final nameController = TextEditingController();
  String selectedGender = 'Pria'; // Default gender
  bool isLoading = false;

  Future<void> loginUser() async {
    final name = nameController.text.trim();

    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Nama harus diisi!")),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      // Query Firestore untuk mencari user
      final querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('name', isEqualTo: name)
          .where('gender', isEqualTo: selectedGender)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Ambil data pertama dari hasil query
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
      print("Terjadi kesalahan: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Terjadi kesalahan saat login")),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Input Nama
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Nama Lengkap"),
            ),
            const SizedBox(height: 16),
            // Dropdown Gender
            DropdownButtonFormField<String>(
              value: selectedGender,
              decoration: const InputDecoration(labelText: "Pilih Gender"),
              items: ['Pria', 'Perempuan']
                  .map((gender) => DropdownMenuItem(
                        value: gender,
                        child: Text(gender),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedGender = value!;
                });
              },
            ),
            const SizedBox(height: 16),
            // Tombol Login
            isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: loginUser,
                    child: const Text("Login"),
                  ),
          ],
        ),
      ),
    );
  }
}

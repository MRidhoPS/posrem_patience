import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:posrem_profileapp/presentation/page/home_page.dart';
import 'package:rive/rive.dart';

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            const HeaderLogin(),
            containerLogin(),
          ],
        ),
      ),
    );
  }

  Padding containerLogin() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Text(
              'Welcome Back To',
              style: GoogleFonts.luckiestGuy(
                color: Colors.white,
                fontSize: 30,
              ),
            ),
            Text(
              'Posrem Website',
              style: GoogleFonts.luckiestGuy(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            TextField(
              controller: nameController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: "Nama Lengkap",
                labelStyle: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w300,
                    fontSize: 16),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(
                    color: Colors.white, // Same color as the border
                    width: 2.5,
                    style: BorderStyle.solid,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(
                    color: Colors.white, // Same color as the border
                    width: 1,
                    style: BorderStyle.solid,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: selectedGender,
              dropdownColor: Colors.black,
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(10))),
              style: const TextStyle(color: Colors.white),
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
            const SizedBox(height: 40),
            // Tombol Login
            isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                        Colors.white.withOpacity(0.3),
                      ),
                      minimumSize: const WidgetStatePropertyAll(
                        Size(
                          double.infinity,
                          50,
                        ),
                      ),
                    ),
                    onPressed: loginUser,
                    child: Text(
                      "Login",
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

class HeaderLogin extends StatelessWidget {
  const HeaderLogin({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.4,
      child: const RiveAnimation.asset(
        'assets/space.riv',
        fit: BoxFit.cover,
      ),
    );
  }
}

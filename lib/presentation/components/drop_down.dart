import 'package:flutter/material.dart';
import 'package:posrem_profileapp/presentation/provider/login_provider.dart';
import 'package:provider/provider.dart';

class DropDownGender extends StatelessWidget {
  DropDownGender({
    super.key,
  });

  // Mendaftarkan list gender di luar widget build untuk menghindari pembuatan ulang setiap kali widget dibangun
  final List<String> genderList = ['Pria', 'Perempuan'];

  @override
  Widget build(BuildContext context) {
    return Selector<LoginProvider, String>(
      // Menggunakan selector untuk hanya rebuild ketika selectedGender berubah
      selector: (context, provider) => provider.selectedGender,
      builder: (context, selectedGender, child) {
        return DropdownButtonFormField<String>(
          value: selectedGender,
          dropdownColor: Colors.white,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0xFF4B4B4B)),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          style: const TextStyle(color: Color(0xFF4B4B4B)),
          items: genderList
              .map((gender) => DropdownMenuItem(
                    value: gender,
                    child: Text(gender),
                  ))
              .toList(),
          onChanged: (value) {
            if (value != null) {
              // Memastikan perubahan pada gender hanya terjadi jika nilainya valid
              context.read<LoginProvider>().setGender(value);
            }
          },
        );
      },
    );
  }
}

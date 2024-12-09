import 'package:flutter/material.dart';
import 'package:posrem_profileapp/presentation/provider/login_provider.dart';
import 'package:provider/provider.dart';

class DropDownGender extends StatelessWidget {
  const DropDownGender({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LoginProvider>(context);

    return DropdownButtonFormField<String>(
      value: provider.selectedGender,
      dropdownColor: Colors.black,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      style: const TextStyle(color: Colors.white),
      items: ['Pria', 'Perempuan']
          .map((gender) => DropdownMenuItem(
                value: gender,
                child: Text(gender),
              ))
          .toList(),
      onChanged: (value) {
        if (value != null) {
          provider.setGender(value); // Ensure value is not null
        }
      },
    );
  }
}

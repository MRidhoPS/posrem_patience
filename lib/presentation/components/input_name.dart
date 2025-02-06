import 'package:flutter/material.dart';
import 'package:posrem_profileapp/presentation/provider/login_provider.dart';
import 'package:provider/provider.dart';

class InputName extends StatelessWidget {
  const InputName({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return Consumer<LoginProvider>(
      builder: (context, provider, child) {
        return TextField(
          controller: provider.nameController,
          style: const TextStyle(color: Color(0xFF4B4B4B)),
          decoration: const InputDecoration(
            labelText: "Nama Lengkap",
            labelStyle: TextStyle(
              color: Color(0xFF4B4B4B),
              fontWeight: FontWeight.w400,
              fontSize: 16,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(
                color:  Color(0xFF4B4B4B),
                width: 2.5,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(
                color:  Color(0xFF4B4B4B),
                width: 1,
              ),
            ),
          ),
        );
      },
    );
  }
}

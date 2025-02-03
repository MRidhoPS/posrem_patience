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
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            labelText: "Nama Lengkap",
            labelStyle: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w300,
              fontSize: 16,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(
                color: Colors.white,
                width: 2.5,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(
                color: Colors.white,
                width: 1,
              ),
            ),
          ),
        );
      },
    );
  }
}

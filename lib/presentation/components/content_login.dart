import 'package:flutter/material.dart';
import 'package:posrem_profileapp/presentation/components/button_login.dart';
import 'package:posrem_profileapp/presentation/components/drop_down.dart';
import 'package:posrem_profileapp/presentation/components/header_login.dart';
import 'package:posrem_profileapp/presentation/components/input_name.dart';

class ContentLogin extends StatelessWidget {
  const ContentLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            const TitleLogin(),
            const SubTitle(),
            const SizedBox(height: 40),
            const InputName(),
            const SizedBox(height: 20),
            DropDownGender(),
            const SizedBox(height: 40),
            const ButtonLogin()
          ],
        ),
      ),
    );
  }
}

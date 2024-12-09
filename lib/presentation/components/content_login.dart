import 'package:flutter/material.dart';
import 'package:posrem_profileapp/presentation/components/button_login.dart';
import 'package:posrem_profileapp/presentation/components/drop_down.dart';
import 'package:posrem_profileapp/presentation/components/header_login.dart';
import 'package:posrem_profileapp/presentation/components/input_name.dart';

class ContentLogin extends StatelessWidget {
  const ContentLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(20.0),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            TitleLogin(),
            SubTitle(),
            SizedBox(height: 40),
            InputName(),
            SizedBox(height: 20),
            DropDownGender(),
            SizedBox(height: 40),
            ButtonLogin()
          ],
        ),
      ),
    );
  }
}

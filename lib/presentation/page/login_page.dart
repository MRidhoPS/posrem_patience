import 'package:flutter/material.dart';
import 'package:posrem_profileapp/presentation/components/content_login.dart';
import 'package:posrem_profileapp/presentation/components/header_login.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              HeaderLogin(),
              ContentLogin(),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:posrem_profileapp/presentation/components/content_login.dart';
import 'package:posrem_profileapp/presentation/components/header_login.dart';
import 'package:posrem_profileapp/util/app_util.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: AppUtil.screenHeight, // ✅ Memberikan batasan tinggi
          ),
          child: const IntrinsicHeight(
            // ✅ Membantu Column menyesuaikan diri
            child: Column(
              children: [
                HeaderLogin(),
                Flexible(
                  // ✅ Menghindari konflik unbounded height
                  fit:
                      FlexFit.loose, // ✅ Memberikan ruang hanya jika diperlukan
                  child: ContentLogin(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

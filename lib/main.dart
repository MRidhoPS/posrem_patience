import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:posrem_profileapp/firebase_options.dart';
import 'package:posrem_profileapp/presentation/page/login_page.dart';
import 'package:posrem_profileapp/presentation/provider/detail_user_provider.dart';
import 'package:posrem_profileapp/presentation/provider/login_provider.dart';
import 'package:posrem_profileapp/util/app_util.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => DetailUserProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => LoginProvider(),
        )
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        AppUtil.init(context);
        return MaterialApp(
          theme: ThemeData(
            scaffoldBackgroundColor: const Color(0xFFE7ECF4),
            appBarTheme: const AppBarTheme(
              backgroundColor: Color(0xFFE7ECF4),
              centerTitle: true,
              iconTheme: IconThemeData(
                color: Colors.black,
                size: 25,
              ),
              titleTextStyle: TextStyle(color: Color(0xFF4B4B4B), fontSize: 16),
            ),
          ),
          home: const LoginPage(),
        );
      },
    );
  }
}

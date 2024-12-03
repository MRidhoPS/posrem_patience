import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:posrem_profileapp/firebase_options.dart';
import 'package:posrem_profileapp/presentation/page/login_page.dart';
import 'package:posrem_profileapp/presentation/provider/detail_user_provider.dart';
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
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(255, 29, 4, 34),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 33, 1, 39),
          centerTitle: true,
          iconTheme: IconThemeData(
            color: Colors.white,
            opacity: 0.5
          ),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 16
          )
        )
      ),
      home: const LoginPage(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rive/rive.dart';

class SubTitle extends StatelessWidget {
  const SubTitle({
    super.key,
  });

  static final textStyle = GoogleFonts.luckiestGuy(
    color: const Color(0xFF4B4B4B),
    fontSize: 24,
  );

  @override
  Widget build(BuildContext context) {
    return Text('Posrem Website', style: textStyle);
  }
}

class TitleLogin extends StatelessWidget {
  const TitleLogin({
    super.key,
  });

  static final textStyle = GoogleFonts.luckiestGuy(
    color: const Color(0xFF4B4B4B),
    fontSize: 30,
  );

  @override
  Widget build(BuildContext context) {
    return Text(
      'Welcome Back To',
      style: textStyle,
    );
  }
}

class HeaderLogin extends StatelessWidget {
  const HeaderLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: double.infinity,
      height: 500,
      child: RiveAnimation.asset(
        antialiasing: false,
        'assets/space.riv',
        fit: BoxFit.cover,
        useArtboardSize: false,
      ),
    );
  }
}

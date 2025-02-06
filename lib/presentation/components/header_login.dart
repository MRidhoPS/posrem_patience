import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rive/rive.dart';

class SubTitle extends StatelessWidget {
  const SubTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      'Posrem Website',
      style: GoogleFonts.luckiestGuy(
        color: const Color(0xFF4B4B4B),
        fontSize: 24,
      ),
    );
  }
}

class TitleLogin extends StatelessWidget {
  const TitleLogin({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      'Welcome Back To',
      style: GoogleFonts.luckiestGuy(
        color: const Color(0xFF4B4B4B),
        fontSize: 30,
      ),
    );
  }
}

class HeaderLogin extends StatelessWidget {
  const HeaderLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.4,
      child: const RiveAnimation.asset(
        'assets/space.riv',
        fit: BoxFit.cover,
      ),
    );
  }
}

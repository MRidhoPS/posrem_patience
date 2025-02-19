import 'package:flutter/material.dart';
import 'package:posrem_profileapp/util/app_util.dart';
import 'package:rive/rive.dart';

class SubTitle extends StatelessWidget {
  const SubTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      'Posrem Website',
      style: AppUtil.subtitleTextStyle,
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
      style: AppUtil.titleTextStyle,
    );
  }
}

class HeaderLogin extends StatelessWidget {
  const HeaderLogin({super.key});

  @override
  Widget build(BuildContext context) {


    return SizedBox(
      width: AppUtil.screenWidth,
      height: AppUtil.screenHeight * 0.4,
      child: const RiveAnimation.asset(
        antialiasing: false,
        'assets/space.riv',
        fit: BoxFit.cover,
        useArtboardSize: false,
      ),
    );
  }
}

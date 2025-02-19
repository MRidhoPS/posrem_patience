import 'package:flutter/material.dart';
import 'package:posrem_profileapp/util/app_util.dart';
import 'package:rive/rive.dart' as rive;

class YearHeader extends StatelessWidget {
  final String year;

  const YearHeader({super.key, required this.year});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      width: AppUtil.screenWidth,
      height: AppUtil.screenHeight * 0.25,
      child: Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.35,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 250, 185, 180),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
            ),
            child: Center(
              child: Text(
                year,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 30,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              child: const rive.RiveAnimation.asset(
                antialiasing: false,
                'assets/rope.riv',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

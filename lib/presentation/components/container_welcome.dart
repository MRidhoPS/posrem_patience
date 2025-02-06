import 'package:flutter/material.dart';

class ContainerWelcome extends StatelessWidget {
  const ContainerWelcome({
    super.key,
    required this.data,
  });

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      margin:  EdgeInsets.zero,
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.2,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Welcome,",
            style: TextStyle(color: Color(0xFF4B4B4B), fontSize: 18),
          ),
          Text(
            "${data['name']}",
            style: const TextStyle(
              color: Color(0xFF4B4B4B),
              fontSize: 34,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

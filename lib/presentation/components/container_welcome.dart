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
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.2,
      color: Colors.white.withOpacity(0.2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Welcome,",
            style: TextStyle(color: Colors.white60, fontSize: 18),
          ),
          Text(
            "${data['name']}",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 34,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

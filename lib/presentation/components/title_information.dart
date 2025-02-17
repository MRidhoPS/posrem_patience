import 'package:flutter/material.dart';

class TitleInformation extends StatelessWidget {
  const TitleInformation({
    super.key,
    required this.data,
  });

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Text(
        '${data['title']}',
        style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            overflow: TextOverflow.ellipsis),
      ),
    );
  }
}

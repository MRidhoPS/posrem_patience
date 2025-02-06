import 'package:flutter/material.dart';
import 'package:posrem_profileapp/data/formatter/data_formatter.dart';

class ContentListData extends StatelessWidget {
  const ContentListData({
    super.key,
    required this.entry,
  });

  final Map<String, dynamic> entry;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Card(
        color: Colors.white.withOpacity(0.2),
        child: ListTile(
          onTap: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => DetailData(
            //       data: entry,
            //       title: Formatter().formatDate(entry),
            //     ),
            //   ),
            // );
          },
          title: Text(
            Formatter().formatDate(entry),
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

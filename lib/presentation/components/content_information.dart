import 'package:flutter/material.dart';

class ContentInformation extends StatelessWidget {
  const ContentInformation({
    super.key,
    required this.title,
    required this.content,
    required this.footer,
  });

  final String title;
  final Map<String, dynamic> content;
  final String? footer;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// **📌 Title**
          Text(
            title,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 10),

          /// **📖 Paragraph Content**
          ListView.builder(
            shrinkWrap: true, // Menggunakan ListView yang efisien
            physics: const NeverScrollableScrollPhysics(),
            itemCount: content.length,
            itemBuilder: (context, index) {
              final entry = content.entries.elementAt(index);
              if (entry.key != 'title') {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    entry.value,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.left,
                  ),
                );
              }
              return const SizedBox
                  .shrink(); // Menghindari title ditampilkan dua kali
            },
          ),

          /// **📎 Footer / Sumber**
          if (footer != null) ...[
            const Divider(),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                '📌 Sumber: $footer',
                style: const TextStyle(
                  fontSize: 14,
                  fontStyle: FontStyle.italic,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

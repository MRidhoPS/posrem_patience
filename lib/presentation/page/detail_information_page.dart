import 'package:flutter/material.dart';

class DetailInformationPage extends StatelessWidget {
  const DetailInformationPage({super.key, required this.data});

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> content = data['content'] ?? {};
    final String title = data['title'] ?? 'Detail Information';
    final String? imageUrl = data['image']; // Ambil URL gambar jika ada
    final String? footer = data['footer']; // Ambil footer jika ada

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detail Information',
          style:  TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        // backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// **🖼 Header Image**
            imageUrl != null
                ? Image.network(
                    imageUrl,
                    width: double.infinity,
                    height: 300,
                    fit: BoxFit.cover,
                  )
                : Container(
                    width: double.infinity,
                    height: 200,
                    color: Colors.grey[300],
                    child: const Center(child: Text('No Image Available')),
                  ),

            /// **📜 Content**
            Padding(
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
                  ...content.entries
                      .where((entry) =>
                          entry.key !=
                          'title') // Hindari menampilkan ulang title
                      .map((entry) => Padding(
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
                          )),

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
            ),
          ],
        ),
      ),
    );
  }
}

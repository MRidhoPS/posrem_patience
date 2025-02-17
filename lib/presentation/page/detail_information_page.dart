import 'package:flutter/material.dart';
import 'package:posrem_profileapp/presentation/components/content_information.dart';

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
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
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
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.error);
                    },
                  )
                : Container(
                    width: double.infinity,
                    height: 200,
                    color: Colors.grey[300],
                    child: const Center(child: Text('No Image Available')),
                  ),

            /// **📜 Content**
            ContentInformation(title: title, content: content, footer: footer),
          ],
        ),
      ),
    );
  }
}
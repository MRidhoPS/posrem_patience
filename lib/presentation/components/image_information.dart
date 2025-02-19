import 'package:flutter/material.dart';
import 'package:posrem_profileapp/util/app_util.dart';

class ImageInformation extends StatelessWidget {
  const ImageInformation({
    super.key,
    required this.data,
  });

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 25),
      width: AppUtil.screenWidth,
      height: AppUtil.screenHeight * 0.18,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: Image.network(
          data['image'],
          fit: BoxFit.fitWidth,
        ),
      ),
    );
  }
}

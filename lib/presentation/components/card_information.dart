import 'package:flutter/material.dart';
import 'package:posrem_profileapp/presentation/components/image_information.dart';
import 'package:posrem_profileapp/presentation/components/title_information.dart';
import 'package:posrem_profileapp/presentation/page/detail_information_page.dart';
import 'package:posrem_profileapp/util/app_util.dart';

class CardInformation extends StatelessWidget {
  const CardInformation({super.key, required this.data});

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailInformationPage(data: data),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        width: AppUtil.screenWidth,
        height: AppUtil.screenHeight * 0.25,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ImageInformation(data: data),
            TitleInformation(data: data)
          ],
        ),
      ),
    );
  }
}




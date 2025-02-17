import 'package:flutter/material.dart';
import 'package:posrem_profileapp/presentation/components/card_information.dart';
import 'package:posrem_profileapp/presentation/provider/detail_user_provider.dart';

class InformationSection extends StatelessWidget {
  const InformationSection({super.key, required this.provider});

  final DetailUserProvider provider;

  @override
  Widget build(BuildContext context) {
    return provider.listInformation.isNotEmpty
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Information",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: provider.informationDetails!.length,
                itemBuilder: (context, index) {
                  String docId =
                      provider.informationDetails!.keys.elementAt(index);
                  Map<String, dynamic> docData =
                      provider.informationDetails![docId]!;
                  return CardInformation(data: docData);
                },
              ),
            ],
          )
        : const SizedBox.shrink();
  }
}

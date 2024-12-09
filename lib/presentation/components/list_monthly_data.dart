import 'package:flutter/material.dart';
import 'package:posrem_profileapp/presentation/components/container_list_data.dart';

class ListMonthlyData extends StatelessWidget {
  const ListMonthlyData({
    super.key,
    required this.monthlyData,
  });

  final List<Map<String, dynamic>> monthlyData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: monthlyData.length,
        itemBuilder: (context, index) {
          var entry = monthlyData[index];

          return ContentListData(entry: entry);
        },
      ),
    );
  }
}

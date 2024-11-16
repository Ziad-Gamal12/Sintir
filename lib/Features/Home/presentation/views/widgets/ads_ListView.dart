import 'package:flutter/material.dart';
import 'package:sintir/Features/Home/presentation/views/widgets/ads_ListViewItem.dart';

class AdsListview extends StatelessWidget {
  const AdsListview({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return SizedBox(
      height: height * .24,
      child: ListView.builder(
          padding: EdgeInsets.zero,
          scrollDirection: Axis.horizontal,
          itemCount: 10,
          itemBuilder: (context, index) {
            return const Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child:
                  AspectRatio(aspectRatio: 350 / 196, child: AdsListviewitem()),
            );
          }),
    );
  }
}

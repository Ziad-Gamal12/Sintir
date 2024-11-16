// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/imageAssets.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/CustomAddFavouriteIcon.dart';
import 'package:sintir/Core/widgets/CustomContentCreatorCircleAvartar.dart';

class BestsellercourseItem extends StatelessWidget {
  const BestsellercourseItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 1),
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
      ),
      child: Stack(
        children: [
          Column(
            children: [
              Expanded(
                flex: 7,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5)),
                  child: SizedBox(
                    width: double.infinity,
                    child: Image.asset(
                      Assets.assetsImagesBestSellerItemImage,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Creatives X Event Vol.2",
                            textAlign: TextAlign.right,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.semiBold11
                                .copyWith(color: Colors.black),
                          ),
                        ],
                      ),
                      const SizedBox(height: 3),
                      Row(
                        children: [
                          const CustomContentCreatorCircleAvartar(
                            imagepath: Assets.assetsImagesBestSellerItemImage,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Creatives X",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.regular10
                                .copyWith(color: const Color(0xff818181)),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: 8,
            left: 8,
            child: CustomAddFavouriteIcon(
              ontap: () {},
            ),
          ),
        ],
      ),
    );
  }
}

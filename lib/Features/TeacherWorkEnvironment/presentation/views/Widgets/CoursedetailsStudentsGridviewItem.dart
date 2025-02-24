import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/SubscriberEntity.dart';
import 'package:sintir/Core/utils/textStyles.dart';

class CoursedetailsStudentsGridviewItem extends StatelessWidget {
  const CoursedetailsStudentsGridviewItem(
      {super.key, required this.subscriberentity});
  final Subscriberentity subscriberentity;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xffF2F2F7),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 80,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(80),
              child: CachedNetworkImage(
                imageUrl: subscriberentity.imageUrl,
                height: 80,
                width: 80,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text.rich(
            TextSpan(children: [
              TextSpan(
                  text: subscriberentity.name,
                  style:
                      AppTextStyles.bold20Auto.copyWith(color: Colors.black)),
              const TextSpan(
                text: " ",
              ),
              TextSpan(
                  text: subscriberentity.gender,
                  style: AppTextStyles.regular10
                      .copyWith(color: const Color(0xff818181)))
            ]),
            textAlign: TextAlign.center,
          ),
          Text(
            subscriberentity.educationLevel,
            style: AppTextStyles.semiBold16
                .copyWith(color: const Color(0xff818181)),
          ),
          Text(
            "ID:${subscriberentity.id}",
            style: AppTextStyles.semiBold16
                .copyWith(color: const Color(0xff818181)),
          ),
        ],
      ),
    );
  }
}

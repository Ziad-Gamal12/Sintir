import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/SubscriberEntity.dart';
import 'package:sintir/Core/utils/textStyles.dart';

class CourseDetailsSubscribersGridviewItem extends StatelessWidget {
  const CourseDetailsSubscribersGridviewItem(
      {super.key, required this.subscriberentity});
  final Subscriberentity subscriberentity;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
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
                errorWidget: (context, url, error) {
                  return const Icon(
                    Icons.person,
                    size: 80,
                  );
                },
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
                  style: AppTextStyles(context)
                      .bold20
                      .copyWith(color: Colors.black)),
              const TextSpan(
                text: " ",
              ),
              TextSpan(
                  text: "(${subscriberentity.gender})",
                  style: AppTextStyles(context)
                      .regular10
                      .copyWith(color: const Color(0xff818181)))
            ]),
            textAlign: TextAlign.center,
          ),
          Text(
            subscriberentity.educationLevel,
            style: AppTextStyles(context)
                .semiBold16
                .copyWith(color: const Color(0xff818181)),
          ),
          Expanded(
            child: SizedBox(
              child: Text(
                "ID:${subscriberentity.id}",
                style: AppTextStyles(context)
                    .regular13
                    .copyWith(color: const Color(0xff818181)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

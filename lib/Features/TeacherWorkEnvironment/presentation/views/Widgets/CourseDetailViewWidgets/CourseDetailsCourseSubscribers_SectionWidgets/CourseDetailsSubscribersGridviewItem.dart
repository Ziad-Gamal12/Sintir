import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/SubscriberEntity.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/CustomCachedNetworkImage.dart';

class CourseDetailsSubscribersGridviewItem extends StatelessWidget {
  const CourseDetailsSubscribersGridviewItem(
      {super.key, required this.subscriberentity});
  final Subscriberentity subscriberentity;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade100,
            blurRadius: 7,
            spreadRadius: 1,
            offset: const Offset(0, 3),
          ),
        ],
        border: Border.all(color: Colors.grey.shade300, width: .5),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 80,
            height: 80,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(80),
              child: CustomCachedNetworkImage(
                imageUrl: subscriberentity.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            subscriberentity.name,
            style: AppTextStyles(context).semiBold20,
          ),
          const Spacer(),
          Row(
            children: [
              const Icon(
                Icons.phone,
                color: Colors.black,
              ),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                child: Text(
                  subscriberentity.phone,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles(context)
                      .regular16
                      .copyWith(color: Colors.black),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              const Icon(
                Icons.school_rounded,
                color: Colors.black,
              ),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                child: Text(
                  subscriberentity.educationLevel,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles(context)
                      .regular16
                      .copyWith(color: Colors.black),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              const Icon(
                Icons.location_on,
                color: Colors.black,
              ),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                child: Text(
                  subscriberentity.address,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles(context)
                      .regular16
                      .copyWith(color: Colors.black),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

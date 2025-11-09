import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/SubscriberEntity.dart';
import 'package:sintir/Core/utils/textStyles.dart';

class CustomSubscriberDetailsCardInformation extends StatelessWidget {
  const CustomSubscriberDetailsCardInformation({
    super.key,
    required this.subscriberentity,
  });

  final SubscriberEntity subscriberentity;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          subscriberentity.name,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyles(context).semiBold20,
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          subscriberentity.phone,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyles(context).regular16,
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          subscriberentity.educationLevel == ""
              ? "غير محدد"
              : subscriberentity.educationLevel,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyles(context).regular16,
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          subscriberentity.address,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyles(context).regular16,
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          subscriberentity.id,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyles(context).regular14,
        ),
      ],
    );
  }
}

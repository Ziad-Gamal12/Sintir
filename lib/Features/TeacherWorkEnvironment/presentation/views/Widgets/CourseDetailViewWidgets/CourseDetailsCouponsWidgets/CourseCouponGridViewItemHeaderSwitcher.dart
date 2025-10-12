import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseCouponEntity.dart';

class CourseCouponGridViewItemHeaderSwitcher extends StatefulWidget {
  const CourseCouponGridViewItemHeaderSwitcher({
    super.key,
    required this.couponEntity,
  });

  final CourseCouponEntity couponEntity;

  @override
  State<CourseCouponGridViewItemHeaderSwitcher> createState() => _CourseCouponGridViewItemHeaderSwitcherState();
}

class _CourseCouponGridViewItemHeaderSwitcherState extends State<CourseCouponGridViewItemHeaderSwitcher> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 40,
      child: Switch(
        activeTrackColor: Colors.grey[450],
        activeThumbColor: Colors.green,
        inactiveTrackColor: Colors.grey.shade100,
        inactiveThumbColor: Colors.grey.shade500,
        value: widget.couponEntity.isActive,
        onChanged: (val) async {
          setState(() {
            widget.couponEntity.isActive = val;
          });
        },
      ),
    );
  }
}

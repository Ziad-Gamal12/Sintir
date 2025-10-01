import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';

class CustomUnAvilableSectionWidget extends StatelessWidget {
  const CustomUnAvilableSectionWidget({
    super.key,
    required this.isAvilabe,
  });

  final bool isAvilabe;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: !isAvilabe,
      child: Positioned.fill(
        child: Container(
          decoration: BoxDecoration(
              color: Colors.transparent.withOpacity(.28),
              borderRadius: BorderRadius.circular(8)),
          alignment: Alignment.center,
          child: IntrinsicWidth(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.lock,
                    color: Colors.red.shade700,
                    size: 30,
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Text(
                    "هذا المحتوى مغلق",
                    style: AppTextStyles(context)
                        .semiBold16
                        .copyWith(color: Colors.red.shade700),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

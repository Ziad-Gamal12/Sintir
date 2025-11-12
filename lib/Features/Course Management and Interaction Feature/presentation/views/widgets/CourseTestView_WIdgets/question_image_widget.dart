import 'package:flutter/material.dart';
import 'package:sintir/Core/widgets/CustomCachedNetworkImage.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CourseTestView_WIdgets/QuestionImageWidgetFillImageIcon.dart';

class QuestionImageWidget extends StatelessWidget {
  const QuestionImageWidget({super.key, this.imageUrl});

  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    if (imageUrl == null || imageUrl!.isEmpty) return const SizedBox();

    return AspectRatio(
      aspectRatio: 3 / 2.5, // adjust ratio based on your layout
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CustomCachedNetworkImage(
                imageUrl: imageUrl!,
                fit: BoxFit.cover, // use cover for better scaling
              ),
            ),
          ),
          Positioned(
            top: 8,
            left: 8,
            child: QuestionImageWidgetFillImageIcon(imageUrl: imageUrl),
          ),
        ],
      ),
    );
  }
}

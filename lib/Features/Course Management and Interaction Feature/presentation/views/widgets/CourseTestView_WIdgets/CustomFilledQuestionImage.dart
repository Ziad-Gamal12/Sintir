import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/test_item_cubit/test_item_cubit.dart';
import 'package:sintir/Core/widgets/CustomCachedNetworkImage.dart';

class CustomFilledQuestionImage extends StatelessWidget {
  const CustomFilledQuestionImage({super.key, required this.image});
  final String image;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context
            .read<TestItemCubit>()
            .resizeQuestionsImages(image: image, isFilled: false);
      },
      child: Container(
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: [
              Colors.white.withOpacity(0.05),
              Colors.white.withOpacity(0.08),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          border: Border.all(
            color: Colors.white.withOpacity(0.15),
            width: 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: AspectRatio(
            aspectRatio: 1,
            child: CustomCachedNetworkImage(
              imageUrl: image,
              fit: BoxFit.contain,
            ),
          ),
        ),
      )
          .animate()
          .fadeIn(duration: const Duration(milliseconds: 600))
          .scale(
            begin: const Offset(0.9, 0.9),
            curve: Curves.easeOutBack,
            duration: const Duration(milliseconds: 500),
          )
          .moveY(
            begin: 50,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeOut,
          ),
    );
  }
}

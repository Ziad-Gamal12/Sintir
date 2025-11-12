import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/test_item_cubit/test_item_cubit.dart';

class QuestionImageWidgetFillImageIcon extends StatelessWidget {
  const QuestionImageWidgetFillImageIcon({
    super.key,
    required this.imageUrl,
  });

  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context
            .read<TestItemCubit>()
            .resizeQuestionsImages(image: imageUrl!, isFilled: true);
      },
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
          color: Colors.black38,
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.fullscreen,
          color: Colors.white,
        ),
      ),
    );
  }
}

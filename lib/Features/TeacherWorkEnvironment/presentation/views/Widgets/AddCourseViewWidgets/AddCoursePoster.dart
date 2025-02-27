import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/utils/imageAssets.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/AddCourseCubit/add_course_cubit.dart';
import 'package:skeletonizer/skeletonizer.dart';

class Addcourseposter extends StatelessWidget {
  const Addcourseposter({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddCourseCubitCubit, AddCourseCubitState>(
        builder: (context, state) {
      return Skeletonizer(
          enabled: state is AddCourseCubitAssetLoading,
          child: context.read<AddCourseCubitCubit>().coursePosterImage == null
              ? InkWell(
                  onTap: () {
                    context.read<AddCourseCubitCubit>().pickCoursePosterImage();
                  },
                  child: Container(
                    padding: const EdgeInsets.only(
                        top: 20, left: 27, right: 27, bottom: 29),
                    decoration: BoxDecoration(
                      color: const Color(0xffF9FAFA),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Image.asset(Assets.assetsImagesAddImageIcon),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          "الصورة المصغرة للدورة",
                          style: AppTextStyles.bold13
                              .copyWith(color: const Color(0xffAEAEB2)),
                        )
                      ],
                    ),
                  ),
                )
              : AspectRatio(
                  aspectRatio: 1 / .95,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.file(
                      context.read<AddCourseCubitCubit>().coursePosterImage!,
                      fit: BoxFit.cover,
                    ),
                  ),
                ));
    });
  }
}

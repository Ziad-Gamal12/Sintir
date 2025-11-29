import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/test_item_cubit/test_item_cubit.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestQuestionEntity.dart';
import 'package:sintir/Core/utils/imageAssets.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/CustomErrorWidget.dart';
import 'package:sintir/locale_keys.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AddCourseExamAddQuestionImage extends StatefulWidget {
  const AddCourseExamAddQuestionImage(
      {super.key, required this.coursetestquestionentity});
  final CourseTestQuestionEntity coursetestquestionentity;
  @override
  State<AddCourseExamAddQuestionImage> createState() =>
      _AddCourseExamAddQuestionImageState();
}

class _AddCourseExamAddQuestionImageState
    extends State<AddCourseExamAddQuestionImage> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<TestItemCubit>().pickQuestionImage();
      },
      child: Container(
        width: double.infinity,
        padding:
            const EdgeInsets.only(top: 20, left: 27, right: 27, bottom: 29),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
        ),
        child: BlocBuilder<TestItemCubit, TestItemState>(
          buildWhen: (previous, current) {
            if (current is PickQuestionImageSuccess ||
                current is PickQuestionImageFailure ||
                current is PickQuestionImageLoading) {
              return true;
            }
            return false;
          },
          builder: (context, state) {
            if (state is PickQuestionImageFailure) {
              return CustomErrorWidget(errormessage: state.errMessage);
            } else if (state is PickQuestionImageSuccess) {
              widget.coursetestquestionentity.imageFile = state.file;
              return Image.file(
                state.file,
                fit: BoxFit.cover,
              );
            } else {
              return Skeletonizer(
                enabled: state is PickQuestionImageLoading,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      Assets.assetsIconsAddImageIcon,
                      height: 25,
                      width: 25,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      LocaleKeys.questionImage,
                      textAlign: TextAlign.center,
                      style: AppTextStyles(context)
                          .semiBold12
                          .copyWith(color: Colors.black),
                    )
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

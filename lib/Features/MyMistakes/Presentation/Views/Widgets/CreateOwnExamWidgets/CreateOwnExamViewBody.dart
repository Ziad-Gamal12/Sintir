import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/helper/GetUserData.dart';
import 'package:sintir/Core/helper/ShowSnackBar.dart';
import 'package:sintir/Core/widgets/CustomButton.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/courseTestView.dart';
import 'package:sintir/Features/MyMistakes/Presentation/Manager/cubit/get_my_mistakes_cubit.dart';
import 'package:sintir/Features/MyMistakes/Presentation/Views/Widgets/CreateOwnExamWidgets/CreateOwnExamViewHeadLine.dart';
import 'package:sintir/Features/MyMistakes/Presentation/Views/Widgets/CreateOwnExamWidgets/CreateOwnExamWarningNote.dart';
import 'package:sintir/Features/MyMistakes/Presentation/Views/Widgets/CreateOwnExamWidgets/CustomQuestionCountSection.dart';
import 'package:sintir/Features/MyMistakes/Presentation/Views/Widgets/CreateOwnExamWidgets/CustomSelectExamSubjectsSection.dart';
import 'package:sintir/constant.dart';
import 'package:sintir/locale_keys.dart';

class CreateOwnExamViewBody extends StatefulWidget {
  const CreateOwnExamViewBody({super.key});

  @override
  State<CreateOwnExamViewBody> createState() => _CreateOwnExamViewBodyState();
}

class _CreateOwnExamViewBodyState extends State<CreateOwnExamViewBody> {
  int questionLimit = 20;
  String? selectedSubject;
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return BlocListener<GetMyMistakesCubit, GetMyMistakesState>(
      listener: (context, state) {
        log("CreateOwnExamViewBody state: $state");
        if (state is CreateCustomExamSuccess) {
          GoRouter.of(context)
              .push(Coursetestview.routename, extra: state.requirements);
        } else if (state is CreateCustomExamFailure) {
          CustomSnackBar.show(
            context,
            message: state.errmessage,
            type: SnackType.error,
          );
        }
      },
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: KHorizontalPadding,
            vertical: KVerticalPadding,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CreateOwnExamViewHeadLine(theme: theme),
                const SizedBox(height: 48),
                CustomSelectExamSubjectsSection(onSubjectSelected: (val) {
                  setState(() {
                    selectedSubject = val;
                  });
                }),
                const SizedBox(height: 48),
                CustomQuestionCountSection(onCountChanged: (val) {
                  setState(() {
                    questionLimit = val;
                  });
                }),
                const SizedBox(height: 48),
                const CreateOwnExamWarningNote(),
                const SizedBox(height: 48),
                BlocSelector<GetMyMistakesCubit, GetMyMistakesState, bool>(
                  selector: (state) {
                    return state is CreateCustomExamLoading;
                  },
                  builder: (context, state) {
                    if (state) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: KMainColor,
                        ),
                      );
                    }
                    return Custombutton(
                        text: LocaleKeys.createButton,
                        color: KMainColor,
                        textColor: Colors.white,
                        onPressed: () {
                          if (selectedSubject != null && questionLimit > 0) {
                            context.read<GetMyMistakesCubit>().createOwnExam(
                                  courseSubject: selectedSubject,
                                  questionLimit: questionLimit,
                                  userUID: getUserData().uid,
                                );
                          } else {
                            CustomSnackBar.show(
                              context,
                              message: LocaleKeys.errorEmptyFields,
                              type: SnackType.error,
                            );
                          }
                        });
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

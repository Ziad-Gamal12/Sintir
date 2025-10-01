import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/Managers/Cubits/test_item_cubit/test_item_cubit.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestViewNavigationsRequirmentsEntity.dart';
import 'package:sintir/Core/helper/GetUserData.dart';
import 'package:sintir/Core/helper/ShowSnackBar.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/AwesomeDialog.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/JoinedByEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/ReviewTestResultView.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CourseTestView_WIdgets/CourseTestControlPanel.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CourseTestView_WIdgets/CourseTestQuestionsNavigation.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CourseTestView_WIdgets/CoursetestquestionItem.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CourseTestView_WIdgets/TestQuestionNavigationButtons.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/addingJoinedByLoadingWidget.dart';
import 'package:sintir/constant.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class CoursetestviewBody extends StatefulWidget {
  const CoursetestviewBody({
    super.key,
  });
  @override
  State<CoursetestviewBody> createState() => _CoursetestviewBodyState();
}

class _CoursetestviewBodyState extends State<CoursetestviewBody> {
  final stopWatchTimer = StopWatchTimer(mode: StopWatchMode.countDown);

  @override
  void initState() {
    if (mounted) {
      intitStateMethod(
          test:
              context.read<Coursetestviewnavigationsrequirmentsentity>().test);
    }
    super.initState();
  }

  int currentQuestionIndex = 0;
  String selectedAnswer = "";

  @override
  Widget build(BuildContext context) {
    CourseTestEntity test = context
        .read<Coursetestviewnavigationsrequirmentsentity>()
        .test; //widget.coursetestentity>
    return BlocConsumer<TestItemCubit, TestItemState>(
      listener: (context, state) {
        if (state is JoinToTestItemSuccess) {
          ShowSnackBar(
              context: context,
              child: Text("تم الانضمام بنجاح",
                  style: AppTextStyles(context)
                      .regular14
                      .copyWith(color: Colors.black)),
              backgroundColor: Colors.grey.shade200);
        } else if (state is JoinToTestItemFailure) {
          ShowSnackBar(
              context: context,
              child: Text(state.errMessage,
                  style: AppTextStyles(context)
                      .regular14
                      .copyWith(color: Colors.white)),
              backgroundColor: Colors.red);
        } else if (state is AddTestResultSuccess) {
          successdialog(
              context: context,
              SuccessMessage: "تم انهاء الاختبار بنجاح",
              btnOkOnPress: () {
                GoRouter.of(context).pushReplacement(
                    Reviewtestresultview.routeName,
                    extra: context.read<TestItemCubit>().getTestResults(
                        context: context, test: test, user: getUserData()));
              }).show();
        } else if (state is AddTestResultFailure) {
          errordialog(context, state.errMessage).show();
        }
      },
      builder: (context, state) {
        return Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: KHorizontalPadding, vertical: 20),
              child: ListView(
                children: [
                  CourseTestControlPanel(
                      stopWatchTimer: stopWatchTimer, widget: widget),
                  Coursetestquestionsnavigation(
                    currentQuestionIndex: currentQuestionIndex,
                    selectQuestionAction: (value) {
                      currentQuestionIndex = value;
                      setState(() {});
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Divider(
                    color: Colors.grey,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CoursetestquestionItem(
                      currentQuestionIndex: currentQuestionIndex,
                      answerChange: (answer) {
                        test.questions[currentQuestionIndex].selectedSolution =
                            answer ?? "";
                        setState(() {});
                      },
                      selectedAnswer: test.questions[currentQuestionIndex]
                              .selectedSolution ??
                          ""),
                  const SizedBox(
                    height: 20,
                  ),
                  TestQuestionNavigationButtons(
                    nextQuestion: () {
                      if (currentQuestionIndex < test.questions.length - 1) {
                        currentQuestionIndex++;
                        test.questions[currentQuestionIndex].isOpened = true;
                        selectedAnswer = "";
                        setState(() {});
                      }
                    },
                    previousQuestion: () {
                      if (currentQuestionIndex > 0) {
                        currentQuestionIndex--;
                        setState(() {});
                      }
                    },
                  )
                ],
              ),
            ),
            Visibility(
              visible: state is JoinToTestItemLoading ? true : false,
              child: const Positioned(
                  bottom: 16,
                  left: 16,
                  right: 16,
                  child: addingJoinedByLoadingWidget()),
            )
          ],
        );
      },
    );
  }

  void intitStateMethod({required CourseTestEntity test}) {
    if (mounted) {
      context.read<TestItemCubit>().joinToTestItem(
            courseId: context
                .read<Coursetestviewnavigationsrequirmentsentity>()
                .course
                .id,
            sectionId: context
                .read<Coursetestviewnavigationsrequirmentsentity>()
                .sectionId,
            sectionItemId: context
                .read<Coursetestviewnavigationsrequirmentsentity>()
                .test
                .id,
            joinedByEntity: JoinedByEntity(
                uid: getUserData().uid,
                name: getUserData().fullName,
                imageUrl: getUserData().profilePicurl,
                joinedDate: DateTime.now()),
          );
    }
    test.questions[0].isOpened = true;
    stopWatchTimer.setPresetMinuteTime(test.durationTime);
    stopWatchTimer.onStartTimer();
  }
}

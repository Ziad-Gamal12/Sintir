import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sintir/Core/Managers/Cubits/CourseSectionsCubit/CourseSectionsCubit.dart';
import 'package:sintir/Core/widgets/AwesomeDialog.dart';
import 'package:sintir/Core/widgets/showSnackBar.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseTestEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseTestViewNavigationsRequirmentsEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/ReviewTestResultView.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CourseTestView_WIdgets/CourseTestControlPanel.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CourseTestView_WIdgets/CourseTestQuestionsNavigation.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CourseTestView_WIdgets/CoursetestquestionItem.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CourseTestView_WIdgets/TestQuestionNavigationButtons.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/addingJoinedByLoadingWidget.dart';
import 'package:sintir/constant.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class CoursetestviewBody extends StatefulWidget {
  const CoursetestviewBody({super.key, required this.coursetestentity});
  final Coursetestentity coursetestentity;
  @override
  State<CoursetestviewBody> createState() => _CoursetestviewBodyState();
}

class _CoursetestviewBodyState extends State<CoursetestviewBody> {
  final stopWatchTimer = StopWatchTimer(mode: StopWatchMode.countDown);

  @override
  void initState() {
    intitStateMethod();
    super.initState();
  }

  int currentQuestionIndex = 0;
  String selectedAnswer = "";

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CourseSectionsCubit, CourseSectionsState>(
      listener: (context, state) {
        if (state is AddJoinedBySuccess) {
          showSnackBar(context, "تم الانضمام بنجاح");
        } else if (state is AddJoinedByFailure) {
          showSnackBar(context, state.errMessage);
        } else if (state is AddTestResultSuccess) {
          successdialog(
              context: context,
              SuccessMessage: "تم انهاء الاختبار بنجاح",
              btnOkOnPress: () {
                GoRouter.of(context).pushReplacement(
                    Reviewtestresultview.routeName,
                    extra: context.read<CourseSectionsCubit>().getTestResults(
                        context: context, test: widget.coursetestentity));
              }).show();
        } else if (state is AddTestResultFailure) {
          errordialog(context, state.errMessage).show();
        }
      },
      builder: (context, state) {
        return Stack(
          children: [
            Provider.value(
              value: widget.coursetestentity,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: KHorizontalPadding, vertical: 20),
                child: ListView(
                  children: [
                    CourseTestControlPanel(
                        totalTime: widget.coursetestentity.durationTime * 1.0,
                        stopWatchTimer: stopWatchTimer,
                        widget: widget),
                    Coursetestquestionsnavigation(
                      currentQuestionIndex: currentQuestionIndex,
                      widget: widget,
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
                        coursetestentity: widget.coursetestentity,
                        currentQuestionIndex: currentQuestionIndex,
                        answerChange: (answer) {
                          widget
                              .coursetestentity
                              .questions[currentQuestionIndex]
                              .selectedSolution = answer ?? "";
                          setState(() {});
                        },
                        selectedAnswer: widget
                                .coursetestentity
                                .questions[currentQuestionIndex]
                                .selectedSolution ??
                            ""),
                    const SizedBox(
                      height: 20,
                    ),
                    TestQuestionNavigationButtons(
                      nextQuestion: () {
                        if (currentQuestionIndex <
                            widget.coursetestentity.questions.length - 1) {
                          currentQuestionIndex++;
                          widget.coursetestentity
                              .questions[currentQuestionIndex].isOpened = true;
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
            ),
            Visibility(
              visible: state is AddJoinedByLoading ? true : false,
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

  void intitStateMethod() {
    if (mounted) {
      context.read<CourseSectionsCubit>().addJoinedBy(
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
            joinedByEntity: context
                .read<CourseSectionsCubit>()
                .getJoinedByEntity(context: context),
          );
    }
    widget.coursetestentity.questions[0].isOpened = true;
    stopWatchTimer.setPresetMinuteTime(widget.coursetestentity.durationTime);
    stopWatchTimer.onStartTimer();
  }
}

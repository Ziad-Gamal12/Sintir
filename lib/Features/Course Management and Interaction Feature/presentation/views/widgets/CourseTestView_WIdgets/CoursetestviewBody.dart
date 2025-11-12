import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/test_item_cubit/test_item_cubit.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestViewNavigationsRequirmentsEntity.dart';
import 'package:sintir/Core/helper/GetUserData.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/JoinedByEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CourseTestView_WIdgets/CourseTestLayout.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CourseTestView_WIdgets/CourseTestListener.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CourseTestView_WIdgets/CustomFilledQuestionImage.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class CourseTestViewBody extends StatefulWidget {
  const CourseTestViewBody({super.key});

  @override
  State<CourseTestViewBody> createState() => _CourseTestViewBodyState();
}

class _CourseTestViewBodyState extends State<CourseTestViewBody> {
  late StopWatchTimer stopWatchTimer;
  int currentQuestionIndex = 0;

  @override
  void initState() {
    super.initState();
    final test =
        context.read<CourseExamViewNavigationsRequirmentsEntity>().test;

    stopWatchTimer = StopWatchTimer(
      mode: StopWatchMode.countDown,
      presetMillisecond: test.durationTime * 60 * 1000,
    );

    _initializeTest(test);
  }

  void _initializeTest(CourseTestEntity test) {
    context.read<TestItemCubit>().joinToTestItem(
          courseId: context
              .read<CourseExamViewNavigationsRequirmentsEntity>()
              .course
              .id,
          sectionId: context
              .read<CourseExamViewNavigationsRequirmentsEntity>()
              .sectionId,
          sectionItemId: test.id,
          joinedByEntity: JoinedByEntity(
            uid: getUserData().uid,
            name: getUserData().fullName,
            imageUrl: getUserData().profilePicurl,
            joinedDate: DateTime.now(),
          ),
        );

    test.questions.first.isOpened = true;
    stopWatchTimer.onStartTimer();
  }

  @override
  void dispose() {
    stopWatchTimer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final courseExamViewNavigationsRequirmentsEntity =
        context.read<CourseExamViewNavigationsRequirmentsEntity>();

    return CourseTestListener(
      test: courseExamViewNavigationsRequirmentsEntity.test,
      stopWatchTimer: stopWatchTimer,
      courseId: courseExamViewNavigationsRequirmentsEntity.course.id,
      builder: (context, state) {
        return Stack(
          children: [
            CourseTestLayout(
              stopWatchTimer: stopWatchTimer,
              test: courseExamViewNavigationsRequirmentsEntity.test,
              currentQuestionIndex: currentQuestionIndex,
              onQuestionChanged: (index) {
                setState(() {
                  currentQuestionIndex = index;
                });
              },
            ),
            if (state is ResizeQuestionsImageSuccess &&
                state.isFilled == true &&
                state.imageUrl != "")
              Positioned.fill(
                  child: CustomFilledQuestionImage(image: state.imageUrl))
          ],
        );
      },
    );
  }
}

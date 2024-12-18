import 'package:flutter/material.dart';
import 'package:sintir/Core/widgets/CustomButton.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseTestEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseTestQuestionEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseTestQuestionSolutionEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CourseTestView_WIdgets/CourseTestViewBodyQuestionsInfo.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CourseTestView_WIdgets/CourseTestViewBodyTestButtonsActions.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CourseTestView_WIdgets/CourseTestViewBodyTimer.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CourseTestView_WIdgets/CoursetestquestionItem.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CourseTestView_WIdgets/CustomCountWidget.dart';
import 'package:sintir/constant.dart';

class CoursetestviewBody extends StatefulWidget {
  const CoursetestviewBody({super.key});

  @override
  State<CoursetestviewBody> createState() => _CoursetestviewBodyState();
}

class _CoursetestviewBodyState extends State<CoursetestviewBody> {
  Coursetestentity coursetestentity =
      Coursetestentity(durationTime: 100, questions: [
    Coursetestquestionentity(
        questionTitle: "ما هو العدد الذرى للعنصر Mg",
        solutions: [
          Coursetestquestionsolutionentity(answer: "14", isCorrect: false),
          Coursetestquestionsolutionentity(answer: "13", isCorrect: false),
          Coursetestquestionsolutionentity(answer: "12", isCorrect: true),
          Coursetestquestionsolutionentity(answer: "16", isCorrect: false),
        ],
        isOpened: false),
    Coursetestquestionentity(
        questionTitle: "ما هو العدد الذرى للعنصر f",
        solutions: [
          Coursetestquestionsolutionentity(answer: "9", isCorrect: false),
          Coursetestquestionsolutionentity(answer: "13", isCorrect: false),
          Coursetestquestionsolutionentity(answer: "34", isCorrect: true),
          Coursetestquestionsolutionentity(answer: "12", isCorrect: false),
        ],
        isOpened: false),
  ]);

  int currentQuestionIndex = 0;
  String selectedAnswer = "";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: KHorizontalPadding, vertical: 20),
      child: ListView(
        children: [
          Coursetestviewbodytimer(
            durationSeconds: coursetestentity.durationTime,
          ),
          const SizedBox(
            height: 20,
          ),
          const CourseTestViewBodyTestButtonsActions(),
          const SizedBox(
            height: 20,
          ),
          CourseTestViewBodyQuestionsInfo(coursetestentity: coursetestentity),
          Wrap(
            children: coursetestentity.questions.asMap().entries.map((e) {
              return InkWell(
                onTap: () {
                  currentQuestionIndex = e.key;
                  setState(() {});
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 40,
                    child: CustomCountWidget(
                      countColor: e.key == currentQuestionIndex
                          ? Colors.red.shade500
                          : Colors.grey.shade300,
                      count: "${e.key + 1}",
                      countTextColor: e.key == currentQuestionIndex
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                ),
              );
            }).toList(),
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
              coursetestentity: coursetestentity,
              currentQuestionIndex: currentQuestionIndex,
              answerChange: (answer) {
                selectedAnswer = answer.toString();
                setState(() {});
              },
              selectedAnswer: selectedAnswer),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: Custombutton(
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    ),
                    text: "التالى",
                    color: KMainColor,
                    textColor: Colors.white,
                    onPressed: () {
                      if (currentQuestionIndex <
                          coursetestentity.questions.length - 1) {
                        currentQuestionIndex++;
                        selectedAnswer = "";
                        setState(() {});
                      }
                    }),
              ),
              Expanded(
                child: Custombutton(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8),
                    bottomLeft: Radius.circular(8),
                  ),
                  text: "السابق",
                  color: Colors.white,
                  textColor: Colors.black,
                  onPressed: () {
                    if (currentQuestionIndex > 0) {
                      currentQuestionIndex--;
                      setState(() {});
                    }
                  },
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

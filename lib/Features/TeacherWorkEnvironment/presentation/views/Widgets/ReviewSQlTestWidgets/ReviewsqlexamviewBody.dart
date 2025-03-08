import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/widgets/AwesomeDialog.dart';
import 'package:sintir/Core/widgets/CustomButton.dart';
import 'package:sintir/Core/widgets/Custom_Loading_Widget.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/navigateSQlReviewRequirmentsEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/CourseDetailView.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/ReviewSQlTestWidgets/CustomReviewSqlQuestionsSLiverList.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/ReviewSQlTestWidgets/CustomReviewSqlTestNameAndDuration.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/ReviewSQlTestWidgets/CustomTitleAndDescriptionSectionInfo.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/AddCourseSectionCubit/AddCourseSectionCubit.dart';
import 'package:sintir/constant.dart';

class ReviewsqlexamviewBody extends StatelessWidget {
  const ReviewsqlexamviewBody(
      {super.key, required this.navigatesqlreviewrequirmentsentity});
  final Navigatesqlreviewrequirmentsentity navigatesqlreviewrequirmentsentity;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddCourseSectionCubit, AddCourseSectionState>(
      listener: (context, state) {
        if (state is AddCourseSectionAddSectionFailure) {
          errordialog(context, state.errMessage).show();
        } else if (state is AddCourseSectionAddSectionSuccess) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => Coursedetailview(
                  courseEntity: navigatesqlreviewrequirmentsentity.courseEntity,
                ),
              ),
              (route) => false);
        }
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: KHorizontalPadding),
          child: Stack(
            children: [
              CustomScrollView(
                slivers: [
                  const SliverToBoxAdapter(
                    child: SizedBox(
                      height: 20,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: CustomTitleAndDescriptionSectionInfo(
                      courseSectionEntity:
                          navigatesqlreviewrequirmentsentity.section,
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: Divider(
                      color: Colors.black,
                      height: 40,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: CustomReviewSqlTestNameAndDuration(
                        coursetestentity: navigatesqlreviewrequirmentsentity
                            .coursetestentity),
                  ),
                  const SliverToBoxAdapter(
                    child: SizedBox(
                      height: 10,
                    ),
                  ),
                  Customreviewsqlquestionssliverlist(
                      questions: navigatesqlreviewrequirmentsentity
                          .coursetestentity.questions),
                ],
              ),
              Positioned(
                bottom: 20,
                left: 0,
                right: 0,
                child: Custom_Loading_Widget(
                  isLoading: state is AddCourseSectionAddSectionLoading,
                  child: Custombutton(
                      text: "اضافة امتحان",
                      color: KMainColor,
                      textColor: Colors.white,
                      onPressed: () {
                        context.read<AddCourseSectionCubit>().addSQlTest(
                            section: navigatesqlreviewrequirmentsentity.section,
                            test: navigatesqlreviewrequirmentsentity
                                .coursetestentity,
                            courseEntity: navigatesqlreviewrequirmentsentity
                                .courseEntity);
                      }),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

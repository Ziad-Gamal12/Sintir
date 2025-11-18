import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/CourseSectionsCubit/CourseSectionsCubit.dart';
import 'package:sintir/Core/Managers/Cubits/test_item_cubit/test_item_cubit.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestEntity.dart';
import 'package:sintir/Core/helper/ShowSnackBar.dart';
import 'package:sintir/Core/widgets/AwesomeDialog.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/navigateExamReviewRequirmentsEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSections_SectionWidgets/CourseDetailsCourseSectionsView.dart';

class ReviewExamSectionViewBodyListener {
  final BuildContext context;

  ReviewExamSectionViewBodyListener(this.context);

  void testItemBlocListener(TestItemState state, BuildContext context) {
    if (state is QuestionsImagesUploadedingSuccuss) {
      questionsImagesUploadedSuccessState(context);
    } else if (state is QuestionsImagesUploadedingFailure) {
      CustomSnackBar.show(
        context,
        message: state.errMessage,
        type: SnackType.error,
      );
    } else if (state is AddTestItemFailure) {
      errordialog(context, state.errMessage).show();
    } else if (state is AddTestItemSuccess) {
      CustomSnackBar.show(
        context,
        message: "تمت الإضافة بنجاح",
        type: SnackType.success,
      );
      CourseTestEntity testItem =
          context.read<NavigateExamReviewRequirmentsEntity>().coursetestentity;
      testItem.dispose();
      Navigator.popUntil(context,
          ModalRoute.withName(CourseDetailsCourseSectionsView.routeName));
    }
  }

  void courseSectionListener(CourseSectionsState state, BuildContext context) {
    if (state is AddCourseSectionFailure) {
      CustomSnackBar.show(
        context,
        message: state.errMessage,
        type: SnackType.error,
      );
    } else if (state is AddCourseSectionSuccess) {
      CustomSnackBar.show(
        context,
        message: "تمت الإضافة بنجاح",
        type: SnackType.success,
      );
      CourseTestEntity testItem =
          context.read<NavigateExamReviewRequirmentsEntity>().coursetestentity;
      testItem.dispose();
      Navigator.popUntil(context,
          ModalRoute.withName(CourseDetailsCourseSectionsView.routeName));
    }
  }

  void questionsImagesUploadedSuccessState(BuildContext context) {
    NavigateExamReviewRequirmentsEntity navigatesqlreviewrequirmentsentity =
        context.read<NavigateExamReviewRequirmentsEntity>();
    if (navigatesqlreviewrequirmentsentity.isNewSection) {
      context.read<CourseSectionsCubit>().addCourseSection(
          sectionItem: navigatesqlreviewrequirmentsentity.coursetestentity,
          courseId: navigatesqlreviewrequirmentsentity.courseEntity.id,
          section: navigatesqlreviewrequirmentsentity.section);
    } else {
      context.read<TestItemCubit>().addTestItem(
          courseId: navigatesqlreviewrequirmentsentity.courseEntity.id,
          sectionId: navigatesqlreviewrequirmentsentity.section.id,
          test: navigatesqlreviewrequirmentsentity.coursetestentity);
    }
  }
}

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/CourseSectionsCubit/CourseSectionsCubit.dart';
import 'package:sintir/Core/Managers/Cubits/test_item_cubit/test_item_cubit.dart';
import 'package:sintir/Core/helper/ShowSnackBar.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/navigateExamReviewRequirmentsEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSections_SectionWidgets/CourseDetailsCourseSectionsView.dart';

class ReviewExamSectionViewBodyListener {
  final BuildContext context;

  ReviewExamSectionViewBodyListener(this.context);

  void testItemBlocListener(TestItemState state, BuildContext context) {
    // بعد نجاح رفع صور الأسئلة، نبدأ رفع صور الحلول
    if (state is QuestionsImagesUploadedingSuccuss) {
      context.read<TestItemCubit>().uploadTestQuestionsSolutionsImages(
            test: context
                .read<NavigateExamReviewRequirmentsEntity>()
                .coursetestentity,
          );
    }
    // بعد نجاح رفع صور الحلول، نضيف الامتحان أو القسم
    else if (state is QuestionsSolutionsImagesUploadedingSuccuss) {
      _addTestOrSection();
    }
    // أي فشل يظهر SnackBar
    else if (state is QuestionsImagesUploadedingFailure ||
        state is QuestionsSolutionsImagesUploadedingFailure ||
        state is AddTestItemFailure) {
      final message = state is QuestionsImagesUploadedingFailure
          ? state.errMessage
          : state is QuestionsSolutionsImagesUploadedingFailure
              ? state.errMessage
              : (state as AddTestItemFailure).errMessage;
      CustomSnackBar.show(context, message: message, type: SnackType.error);
    }
    // نجاح إضافة الامتحان
    else if (state is AddTestItemSuccess) {
      CustomSnackBar.show(context,
          message: "تمت الإضافة بنجاح", type: SnackType.success);
      context
          .read<NavigateExamReviewRequirmentsEntity>()
          .coursetestentity
          .dispose();
      Navigator.popUntil(context,
          ModalRoute.withName(CourseDetailsCourseSectionsView.routeName));
    }
  }

  void courseSectionListener(CourseSectionsState state, BuildContext context) {
    if (state is AddCourseSectionFailure) {
      CustomSnackBar.show(context,
          message: state.errMessage, type: SnackType.error);
    } else if (state is AddCourseSectionSuccess) {
      CustomSnackBar.show(context,
          message: "تمت الإضافة بنجاح", type: SnackType.success);
      context
          .read<NavigateExamReviewRequirmentsEntity>()
          .coursetestentity
          .dispose();
      Navigator.popUntil(context,
          ModalRoute.withName(CourseDetailsCourseSectionsView.routeName));
    }
  }

  // دالة خاصة لإضافة الامتحان أو القسم بعد رفع كل الصور
  void _addTestOrSection() {
    final navigatesqlreviewrequirmentsentity =
        context.read<NavigateExamReviewRequirmentsEntity>();
    if (navigatesqlreviewrequirmentsentity.isNewSection) {
      context.read<CourseSectionsCubit>().addCourseSection(
            sectionItem: navigatesqlreviewrequirmentsentity.coursetestentity,
            courseId: navigatesqlreviewrequirmentsentity.courseEntity.id,
            section: navigatesqlreviewrequirmentsentity.section,
          );
    } else {
      context.read<TestItemCubit>().addTestItem(
            courseId: navigatesqlreviewrequirmentsentity.courseEntity.id,
            sectionId: navigatesqlreviewrequirmentsentity.section.id,
            test: navigatesqlreviewrequirmentsentity.coursetestentity,
          );
    }
  }
}

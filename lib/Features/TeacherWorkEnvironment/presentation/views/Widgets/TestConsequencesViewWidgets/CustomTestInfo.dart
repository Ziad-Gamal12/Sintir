import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestEntity.dart';
import 'package:sintir/Core/helper/ShowBottomSheet.dart';
import 'package:sintir/Core/repos/Test-Item-Repo/TestItemRepo.dart';
import 'package:sintir/Core/services/get_it_Service.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TestConsequencesViewWidgets/UpdateTestInfoBottomSheet/UpdateTestInfoBottomSheet.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/update_test_cubit/update_test_cubit.dart';

class CustomTestInfo extends StatelessWidget {
  const CustomTestInfo({
    super.key,
    required this.test,
    required this.courseId,
    required this.sectionId,
  });

  final CourseTestEntity test;
  final String courseId;
  final String sectionId;
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Color titleColor = theme.textTheme.bodyLarge!.color!;
    final Color idColor = theme.textTheme.bodySmall!.color!.withOpacity(0.7);

    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                test.title,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles(context)
                    .semiBold20
                    .copyWith(color: titleColor),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                test.id,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style:
                    AppTextStyles(context).regular14.copyWith(color: idColor),
              ),
            ],
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        IconButton(
            onPressed: () {
              showCustomBottomSheet(
                child: BlocProvider(
                  create: (context) => UpdateTestCubit(
                    testitemrepo: getIt<Testitemrepo>(),
                  ),
                  child: UpdateTestInfoBottomSheet(
                    courseId: courseId,
                    sectionId: sectionId,
                    coursetestentity: test,
                  ),
                ),
                context: context,
              );
            },
            icon: Icon(
              Icons.settings,
              color: theme.iconTheme.color,
            ))
      ],
    );
  }
}

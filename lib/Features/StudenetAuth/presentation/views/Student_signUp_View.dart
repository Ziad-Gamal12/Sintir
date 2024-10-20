import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/services/get_it_Service.dart';
import 'package:sintir/Core/utils/imageAssets.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/StudenetAuth/domain/repos/studentAuth_repo.dart';
import 'package:sintir/Features/StudenetAuth/presentation/manager/student_sign_up_cubit/student_sign_up_cubit.dart';
import 'package:sintir/Features/StudenetAuth/presentation/views/widgets/StudentSignupViewBody.dart';
import 'package:svg_flutter/svg.dart';

class StudentSignupView extends StatelessWidget {
  const StudentSignupView({super.key});
  static const routeName = "/StudentSignupView";
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StudentSignUpCubit(getIt<StudentauthRepo>()),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                GoRouter.of(context).pop();
              },
              icon: SvgPicture.asset(
                Assets.assetsImagesArrowLeftBack,
                height: 30,
                width: 30,
              )),
          title: Text(
            "انشاء حساب",
            style: AppTextStyles.bold19Auto.copyWith(color: Colors.black),
          ),
          centerTitle: true,
        ),
        body: const StudentSignupViewBody(),
      ),
    );
  }
}

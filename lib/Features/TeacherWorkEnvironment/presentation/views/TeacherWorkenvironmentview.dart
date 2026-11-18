import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/helper/GetUserData.dart';
import 'package:sintir/Core/services/get_it_Service.dart';
import 'package:sintir/Core/widgets/CustomAppBar.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Repos/TeacherLiveWalletRepo.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Repos/TeacherWorkspaceRepo.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkspace/TeacherWorkspaceViewBody.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/teacher_courses_cubit/teacher_courses_cubit.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/teacher_wallet_cubit/teacher_wallet_cubit.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/teacher_workspace_insights_cubit/teacher_workspace_insights_cubit.dart';
import 'package:sintir/locale_keys.dart';

class TeacherWorkenvironmentview extends StatelessWidget {
  const TeacherWorkenvironmentview({super.key});
  static const routeName = '/TeacherWorkenvironmentview';

  @override
  Widget build(BuildContext context) {
    final teacherId = getUserData().uid;
    return Scaffold(
      appBar: CustomAppBar(appBartitle: LocaleKeys.workEnvironment),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => TeacherCoursesCubit(
              repo: getIt<TeacherWorkspaceRepo>(),
              teacherId: teacherId,
            )..load(),
          ),
          BlocProvider(
            create: (context) => TeacherWorkspaceInsightsCubit(
              repo: getIt<TeacherWorkspaceRepo>(),
            ),
          ),
          BlocProvider(
            create: (context) => TeacherWalletCubit(
              walletRepo: getIt<TeacherLiveWalletRepo>(),
              teacherId: teacherId,
            )..watchWallet(),
          ),
        ],
        child: const TeacherWorkspaceViewBody(),
      ),
    );
  }
}

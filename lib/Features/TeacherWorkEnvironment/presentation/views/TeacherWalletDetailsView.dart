import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/repos/PaymobPayoutRepo/PayoutRepo.dart';
import 'package:sintir/Core/repos/TeacherTranscationsRepo/TeacherTranscationsRepo.dart';
import 'package:sintir/Core/services/get_it_Service.dart';
import 'package:sintir/Core/widgets/CustomAppBar.dart';
import 'package:sintir/Core/widgets/SensitivePageWrapper.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Repos/TeacherWalletRepo.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWalletDetailsViewWidgets/TeacherWalletDetailsViewBody.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/WithDrawTeacherBalanceCubit/WithDrawTeacherBalanceCubit.dart';
import 'package:sintir/locale_keys.dart';

class TeacherWalletDetailsView extends StatelessWidget {
  const TeacherWalletDetailsView({
    super.key,
  });
  static const routeName = '/TeacherWalletDetailsView';
  @override
  Widget build(BuildContext context) {
    return SensitivePageWrapper(
      child: BlocProvider(
        create: (context) => WithDrawTeacherBalanceCubit(
          transcationsRepo: getIt<TeacherTranscationsRepo>(),
          teacherWalletRepo: getIt<TeacherWalletRepo>(),
          paymobPayoutRepo: getIt<PayoutRepo>(),
        ),
        child: Scaffold(
          appBar: CustomAppBar(appBartitle: LocaleKeys.walletDetailsTitle),
          body: const TeacherWalletDetailsViewBody(),
        ),
      ),
    );
  }
}

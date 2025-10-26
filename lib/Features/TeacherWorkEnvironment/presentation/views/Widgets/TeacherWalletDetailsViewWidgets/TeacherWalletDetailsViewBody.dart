import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/helper/GetUserData.dart';
import 'package:sintir/Core/helper/ShowBottomSheet.dart';
import 'package:sintir/Core/repos/PaymobPayoutRepo/PaymobPayoutRepo.dart';
import 'package:sintir/Core/services/get_it_Service.dart';
import 'package:sintir/Core/widgets/CustomButton.dart';
import 'package:sintir/Features/Auth/Domain/Entities/UserEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Repos/TeacherWalletRepo.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWalletDetailsViewWidgets/PayOutBalanceWidgets/PayOutBalanceBody.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWalletDetailsViewWidgets/TeacherWalletBalanceDeatils.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWalletDetailsViewWidgets/TeacherWalletDetailsViewBodyWalletCardHeader.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWalletDetailsViewWidgets/teacher_wallet_balance_details_row.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkenvironmentviewWidgets/CustomTeacherCardItem.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/payout_cubit/payout_cubit.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/update_teacher_wallet_cubit/update_teacher_wallet_cubit.dart';
import 'package:sintir/constant.dart';

class TeacherWalletDetailsViewBody extends StatelessWidget {
  const TeacherWalletDetailsViewBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    UserEntity user = getUserData();
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: KHorizontalPadding, vertical: KVerticalPadding),
      child: Column(
        children: [
          TeacherWalletDetailsViewBodyWalletCardHeader(
            status: user.teacherExtraDataEntity?.wallet.status ?? "",
          ),
          CustomTeacherCardItem(
            user: user,
          ),
          Divider(
            color: Colors.grey.shade300,
            thickness: 1,
            height: 20,
          ),
          const TeacherWalletBalanceDetails(),
          const Spacer(),
          Column(
            children: [
              TeacherWalletBalanceDetailsRow(
                icon: Icons.calendar_month_outlined,
                title: "تاريخ الانشاء",
                value: "${user.teacherExtraDataEntity?.wallet.createdAt}",
              ),
              Divider(color: Colors.grey.shade100, height: 20),
              TeacherWalletBalanceDetailsRow(
                icon: Icons.calendar_month_outlined,
                title: "تاريخ التحديث",
                value: user.teacherExtraDataEntity?.wallet.updatedAt ?? "",
              ),
            ],
          ),
          const Spacer(
            flex: 2,
          ),
          Custombutton(
              text: "سحب رصيد",
              color: KMainColor,
              textColor: Colors.white,
              onPressed: () {
                showCustomBottomSheet(
                    child: IntrinsicHeight(
                      child: MultiBlocProvider(
                        providers: [
                          BlocProvider(
                            create: (context) => PayoutCubit(
                              payoutRepo: getIt<PaymobPayoutRepo>(),
                            ),
                          ),
                          BlocProvider(
                            create: (context) => UpdateTeacherWalletCubit(
                              teacherWalletRepo: getIt<TeacherWalletRepo>(),
                            ),
                          ),
                        ],
                        child: PayOutBalanceBody(
                          walletEntity: user.teacherExtraDataEntity!.wallet,
                        ),
                      ),
                    ),
                    context: context);
              })
        ],
      ),
    );
  }
}

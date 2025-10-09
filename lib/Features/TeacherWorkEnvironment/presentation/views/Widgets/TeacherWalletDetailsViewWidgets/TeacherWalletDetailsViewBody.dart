import 'package:flutter/material.dart';
import 'package:sintir/Core/helper/GetUserData.dart';
import 'package:sintir/Core/widgets/CustomButton.dart';
import 'package:sintir/Features/Auth/Domain/Entities/UserEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWalletDetailsViewWidgets/TeacherWalletBalanceDeatils.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWalletDetailsViewWidgets/TeacherWalletDetailsViewBodyWalletCardHeader.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWalletDetailsViewWidgets/teacher_wallet_balance_details_row.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkenvironmentviewWidgets/CustomTeacherCardItem.dart';
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
              onPressed: () {})
        ],
      ),
    );
  }
}
